//
//  Created by Evrim Persembe on 4/24/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import Foundation

class RoomServiceCart {
    static let shared = RoomServiceCart()
    
    public var cartItems: [RoomServiceCartItem] = []
    
    var total: Decimal {
        get { return cartItems.reduce(0, { result, cartItem in result + cartItem.totalPrice }) }
    }
    
    func add(item: RoomServiceCartItem) {
        cartItems.append(item)
    }
}
