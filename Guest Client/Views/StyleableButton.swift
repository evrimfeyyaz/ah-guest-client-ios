//
//  Created by Evrim Persembe on 6/11/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

@IBDesignable class StyleableButton: UIButton {
    @IBInspectable var style: String? {
        didSet {
            if let style = style,
                let buttonStyle = ButtonStyleFactory.styles[style] {
                apply(style: buttonStyle)
            }
        }
    }
    
    private func apply(style: ButtonStyle) {
        layer.cornerRadius = style.cornerRadius
        layer.borderWidth = style.borderWidth
        layer.borderColor = style.borderColor.cgColor
        backgroundColor = style.backgroundColor
        tintColor = style.tintColor
        contentEdgeInsets = style.contentEdgeInsets
    }
}
