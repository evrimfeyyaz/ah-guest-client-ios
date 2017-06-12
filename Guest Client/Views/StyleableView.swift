//
//  Created by Evrim Persembe on 6/11/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

@IBDesignable class StyleableView: UIView {
    @IBInspectable var style: String? {
        didSet {
            if let style = style,
                let viewStyle = ViewStyleFactory.styles[style] {
                apply(style: viewStyle)
            }
        }
    }
    
    private func apply(style: ViewStyle) {
        backgroundColor = style.backgroundColor
    }
}

