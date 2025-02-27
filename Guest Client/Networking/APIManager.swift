//
//  Created by Evrim Persembe on 6/10/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import Foundation
import Alamofire
import Locksmith

enum APIManagerError: Error {
    case jsonSerialization(reason: String)
    case userAuthentication(reason: String)
    case userNotAuthenticated(reason: String)
    case noCurrentReservation(reason: String)
    case apiProvidedError(messages: [String])
    case unableToLoadAuthenticationFromStore(reason: String)
    case invalidAuthentication(reason: String)
}

class APIManager {
    static let shared = APIManager(requestAdapter: APIHeadersAdapter())
    
    let sessionManager = Alamofire.SessionManager.default
    var currentUser: User? {
        didSet {
            guard let currentUser = currentUser else { return }
            
            saveAuthenticationInKeychain(userID: currentUser.id, authToken: currentUser.authToken)
        }
    }
    
    var hasAuthenticatedUser: Bool {
        get {
            return currentUser != nil
        }
    }
    
    init(requestAdapter adapter: RequestAdapter) {
        self.sessionManager.adapter = adapter
    }
    
    // MARK: - Authentication
    func createAuthentication(email: String, password: String, completion: @escaping (Result<User>) -> Void) {
        let parameters: [String: Any] = [
            "user": [
                "email": email,
                "password": password
            ]
        ]
        
        sessionManager.request(APIRouter.createAuthentication(parameters: parameters))
            .validate(statusCode: [200])
            .responseJSON { response in
                switch response.result {
                case .success:
                    let result = self.user(from: response)
                    self.currentUser = result.value
                    
                    completion(result)
                case .failure(let error):
                    if response.response?.statusCode == 401 {
                        completion(.failure(APIManagerError.userAuthentication(reason: "E-mail or password is wrong.")))
                    } else {
                        completion(.failure(error))
                    }
                }
        }
    }
    
    func loadCurrentUserFromStoredAuthentication(completion: @escaping (Result<User>) -> Void) {
        guard let authenticationData = Locksmith.loadDataForUserAccount(userAccount: "khotel.automatedhotel.com") else {
            completion(.failure(APIManagerError.unableToLoadAuthenticationFromStore(reason: "Can't load stored authentication data.")))
            return
        }
        
        guard let userID = authenticationData["userID"] as? Int, let authToken = authenticationData["authToken"] as? String else {
            completion(.failure(APIManagerError.unableToLoadAuthenticationFromStore(reason: "Stored authentication data seems to be corrupt.")))
            return
        }
        
        let authenticationHeaders: HTTPHeaders = [
            "Authorization": authToken,
            "ah-user-id": "\(userID)"
        ]
        
        sessionManager.request(APIRouter.getUser(id: userID).urlRequest!.url!, headers: authenticationHeaders)
            .validate(statusCode: [200])
            .responseJSON { response in
                switch response.result {
                case .success:
                    let result = self.user(from: response)
                    self.currentUser = result.value
                    
                    completion(result)
                case .failure(let error):
                    if response.response?.statusCode == 404 {
                        try? Locksmith.deleteDataForUserAccount(userAccount: "khotel.automatedhotel.com")
                        
                        completion(.failure(APIManagerError.invalidAuthentication(reason: "Stored authentication data is invalid.")))
                    } else {
                        completion(.failure(error))
                    }
                }
        }
    }
    
    private func saveAuthenticationInKeychain(userID: Int, authToken: String) {
        try? Locksmith.updateData(data: ["userID": userID,
                                         "authToken": authToken],
                                  forUserAccount: "khotel.automatedhotel.com")
    }
    
    // MARK: - User
    func createUser(email: String, firstName: String, lastName: String, password: String, passwordConfirmation: String,
                    completion: @escaping (Result<User>) -> Void) {
        let parameters: [String: Any] = [
            "user": [
                "email": email,
                "first_name": firstName,
                "last_name": lastName,
                "password": password,
                "password_confirmation": passwordConfirmation
            ]
        ]
        
        sessionManager.request(APIRouter.createUser(parameters: parameters))
            .validate(statusCode: [201])
            .responseJSON { response in
                switch response.result {
                case .success:
                    let result = self.user(from: response)
                    
                    self.currentUser = result.value
                    
                    completion(result)
                case .failure(let error):
                    if response.response?.statusCode == 422,
                        let apiProvidedErrorMessages = self.apiProvidedErrorMessages(from: response) {
                        completion(.failure(APIManagerError.apiProvidedError(messages: apiProvidedErrorMessages)))
                    } else {
                        completion(.failure(error))
                    }
                }
        }
    }
    
    private func user(from response: DataResponse<Any>) -> Result<User> {
        guard let json = response.result.value as? [String: Any],
            let user = User(json: json) else {
                return .failure(APIManagerError.jsonSerialization(reason: "Received invalid JSON data."))
        }
        
        return .success(user)
    }
    
    // MARK: - Reservations
    func createReservationAssociation(byCheckInDate checkInDate: Date, roomNumber: String, completion: @escaping (Result<Reservation>) -> Void) {
        let parameters: [String: Any] = [
            "reservation_association": [
                "reservation_attributes": [
                    "check_in_date": checkInDate.iso8601FullDate,
                    "room_number": roomNumber
                ]
            ]
        ]
        
        createReservationAssociation(parameters: parameters, completion: completion)
    }
    
    func createReservationAssociation(byConfirmationCode confirmationCode: String, completion: @escaping (Result<Reservation>) -> Void) {
        let parameters: [String: Any] = [
            "reservation_association": [
                "reservation_attributes": [
                    "confirmation_code": confirmationCode
                ]
            ]
        ]
        
        createReservationAssociation(parameters: parameters, completion: completion)
    }
    
    private func createReservationAssociation(parameters: [String: Any], completion: @escaping (Result<Reservation>) -> Void) {
        guard let currentUser = currentUser else {
            completion(.failure(APIManagerError.userNotAuthenticated(reason: "User not signed in.")))
            return
        }
        
        sessionManager.request(APIRouter.createReservationAssociation(userID: currentUser.id, parameters: parameters))
            .validate(statusCode: [200])
            .responseJSON { response in
                switch response.result {
                case .success:
                    let result = self.reservation(from: response)
                    
                    if let currentUser = self.currentUser,
                        let reservation = result.value {
                        currentUser.reservations.append(reservation)
                    }
                    
                    completion(result)
                case .failure(let error):
                    if response.response?.statusCode == 422,
                        let apiProvidedErrorMessages = self.apiProvidedErrorMessages(from: response) {
                        completion(.failure(APIManagerError.apiProvidedError(messages: apiProvidedErrorMessages)))
                    } else {
                        completion(.failure(error))
                    }
                }
        }
    }
    
    private func reservation(from response: DataResponse<Any>) -> Result<Reservation> {
        guard let json = response.result.value as? [String: Any],
            let reservationJSON = json["reservation"] as? [String: Any],
            let reservation = Reservation(json: reservationJSON)
            else { return .failure(APIManagerError.jsonSerialization(reason: "Received invalid JSON data")) }
        
        return .success(reservation)
    }
    
    // MARK: - Room Service Categories
    func indexRoomServiceCategories(completion: @escaping (Result<[RoomServiceCategory]>) -> Void) {
        sessionManager.request(APIRouter.indexRoomServiceCategories)
            .validate(statusCode: [200])
            .responseJSON { response in
                switch response.result {
                case .success:
                    let result = self.roomServiceCategoriesArray(from: response)
                    
                    completion(result)
                case .failure(let error):
                    completion(.failure(error))
                }
        }
    }
    
    private func roomServiceCategoriesArray(from response: DataResponse<Any>) -> Result<[RoomServiceCategory]> {
        guard let jsonArray = response.result.value as? [[String: Any]] else {
            return .failure(APIManagerError.jsonSerialization(reason: "Received invalid JSON data."))
        }
        
        let roomServiceCategories = jsonArray.flatMap { RoomServiceCategory(json: $0) }
        
        return .success(roomServiceCategories)
    }
    
    // MARK: - Room Service Sub-Categories
    func indexRoomServiceSubCategories(categoryID: Int, completion: @escaping (Result<[RoomServiceSubCategory]>) -> Void) {
        sessionManager.request(APIRouter.indexRoomServiceSubCategories(categoryID: categoryID))
            .validate(statusCode: [200])
            .responseJSON { response in
                switch response.result {
                case .success:
                    let result = self.roomServiceCategorySectionsArray(from: response)
                    
                    completion(result)
                case .failure(let error):
                    completion(.failure(error))
                }
        }
    }
    
    private func roomServiceCategorySectionsArray(from response: DataResponse<Any>) -> Result<[RoomServiceSubCategory]> {
        guard let jsonArray = response.result.value as? [[String: Any]] else {
            return .failure(APIManagerError.jsonSerialization(reason: "Received invalid JSON data."))
        }
        
        let roomServiceSections = jsonArray.flatMap { RoomServiceSubCategory(json: $0) }
        
        return .success(roomServiceSections)
    }
    
    // MARK: - Room Service Items
    func showRoomServiceItem(id: Int, completion: @escaping (Result<RoomServiceItem>) -> Void) {
        sessionManager.request(APIRouter.showRoomServiceItem(id: id))
            .validate(statusCode: [200])
            .responseJSON { response in
                switch response.result {
                case .success:
                    let result = self.roomServiceItem(from: response)
                    
                    completion(result)
                case .failure(let error):
                    completion(.failure(error))
                }
        }
    }
    
    private func roomServiceItem(from response: DataResponse<Any>) -> Result<RoomServiceItem> {
        guard let json = response.result.value as? [String: Any],
            let roomServiceItem = RoomServiceItem(json: json)
            else {
                return .failure(APIManagerError.jsonSerialization(reason: "Received invalid JSON data."))
        }
        
        return .success(roomServiceItem)
    }
    
    // MARK: - Room Service Orders
    func createRoomServiceOrder(completion: @escaping (Result<Any>) -> Void) {
        guard hasAuthenticatedUser else {
            completion(.failure(APIManagerError.userNotAuthenticated(reason: "User not signed in.")))
            return
        }
        
        guard let currentUser = currentUser,
            let currentReservation = currentUser.currentReservation
            else {
                completion(.failure(APIManagerError.noCurrentReservation(reason: "User does not have a current reservation.")))
                return
        }
        
        let parameters: [String: Any] = [
            "room_service_order": RoomServiceOrder.cart.toJSON(reservation: currentReservation)
        ]
        
        sessionManager.request(APIRouter.createRoomServiceOrder(userID: currentUser.id, parameters: parameters))
            .validate(statusCode: [201])
            .responseJSON { response in
                switch response.result {
                case .success:
                    completion(response.result)
                case .failure(let error):
                    if response.response?.statusCode == 422,
                        let apiProvidedErrorMessages = self.apiProvidedErrorMessages(from: response) {
                        completion(.failure(APIManagerError.apiProvidedError(messages: apiProvidedErrorMessages)))
                    } else {
                        completion(.failure(error))
                    }
                }
        }
    }
    
    // MARK: - General
    private func apiProvidedErrorMessages(from response: DataResponse<Any>) -> [String]? {
        guard let data = response.data,
            let json = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any],
            let errorsJSON = json["errors"] as? [String: Any]
            else { return nil }
        
        var fullMessages = [String]()
        for attributeErrorsJSONArray in errorsJSON.values {
            guard let attributeErrorsJSONArray = attributeErrorsJSONArray as? [[String: Any]] else { continue }
            
            let fullMessagesForAttribute = attributeErrorsJSONArray.flatMap { $0["full_message"] as? String }
            fullMessages.append(contentsOf: fullMessagesForAttribute)
        }
        
        return fullMessages.count > 0 ? fullMessages : nil
    }
}










