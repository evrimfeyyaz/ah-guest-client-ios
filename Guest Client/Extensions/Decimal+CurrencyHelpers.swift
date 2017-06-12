//
//  Decimal+CurrencyHelpers.swift
//  Guest Client
//
//  Created by Evrim Persembe on 4/20/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import Foundation

extension Decimal {
    
    private static let chNumberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.currencyCode = "BHD"
        numberFormatter.numberStyle = .currency
        
        return numberFormatter
    }()
    
    var stringInBahrainiDinars: String? {
        get { return Decimal.chNumberFormatter.string(from: self as NSDecimalNumber) }
    }
    
}
