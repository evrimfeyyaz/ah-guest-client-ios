//
//  Created by Evrim Persembe on 4/24/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import Foundation

class RoomServiceOrder {
    static let cart = RoomServiceOrder()
    
    public var cartItems: [RoomServiceCartItem] = []
    
    var total: Decimal {
        get { return cartItems.reduce(0, { result, cartItem in result + cartItem.totalPrice }) }
    }
    
    func add(item: RoomServiceCartItem) {
        cartItems.append(item)
    }
    
    func toJSON(reservation: Reservation) -> [String: Any] {
        let cartItemsAttributes = cartItems.enumerated().reduce([String: Any]()) {
            result, indexedCartItem in
            
            var mutableResult = result
            mutableResult["\(indexedCartItem.offset)"] = indexedCartItem.element.toJSON()
            
            return mutableResult
        }
        
        return [
            "reservation_id": reservation.id,
            "cart_items_attributes": cartItemsAttributes
        ]
    }
}
