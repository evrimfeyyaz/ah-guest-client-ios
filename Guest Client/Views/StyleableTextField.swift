//
//  Created by Evrim Persembe on 6/11/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

@IBDesignable class StyleableTextField: UITextField {
    @IBInspectable var style: String? {
        didSet {
            if let style = style,
                let textFieldStyle = TextFieldStyleFactory.styles[style] {
                apply(style: textFieldStyle)
            }
        }
    }
    
    private func apply(style: TextFieldStyle) {
        self.backgroundColor = style.backgroundColor
        self.font = style.font
        self.textColor = style.textColor
        self.borderStyle = style.borderStyle
        self.tintColor = style.tintColor
    }
}
