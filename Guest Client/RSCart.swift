//
//  RSCart.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/24/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import Foundation

class RSCart {
    
    static let shared = RSCart()
    
    private(set) public var cartItems: [RSCartItem] = []
    
    var total: Decimal {
        get { return cartItems.reduce(0, { result, cartItem in result + cartItem.totalPrice }) }
    }
    
    func add(item: RSCartItem) {
        cartItems.append(item)
    }
    
}
