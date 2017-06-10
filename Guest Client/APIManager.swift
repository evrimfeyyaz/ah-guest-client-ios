//
//  Created by Evrim Persembe on 6/10/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
    static let sharedInstance = APIManager(requestAdapter: APIHeadersAdapter())
    
    let sessionManager = Alamofire.SessionManager.default
    
    init(requestAdapter adapter: RequestAdapter) {
        self.sessionManager.adapter = adapter
    }
    
    func indexRoomServiceCategories(completion: @escaping (Result<[RoomServiceCategory]>) -> Void) {
        sessionManager.request(RoomServiceCategoryRouter.index)
            .validate(statusCode: [200])
            .responseJSON { response in
                switch response.result {
                case .success:
                    let result = self.roomServiceCategoriesArrayFromResponse(response: response)
                    
                    completion(result)
                case .failure(let error):
                    completion(.failure(error))
                }
        }
    }
    
    private func roomServiceCategoriesArrayFromResponse(response: DataResponse<Any>) -> Result<[RoomServiceCategory]> {
        guard let jsonArray = response.result.value as? [[String: Any]] else {
            return .failure(APIManagerError.jsonSerialization(reason: "Received invalid JSON data"))
        }
        
        let roomServiceCategories = jsonArray.flatMap { RoomServiceCategory(json: $0) }
        
        return .success(roomServiceCategories)
    }
}
