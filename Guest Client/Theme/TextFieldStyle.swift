//
//  Created by Evrim Persembe on 6/11/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

struct TextFieldStyle {
    let backgroundColor: UIColor
    let font: UIFont
    let textColor: UIColor
    let borderStyle: UITextBorderStyle
    let tintColor: UIColor
}

class TextFieldStyleFactory {
    static let styles = [
        "primary": TextFieldStyleFactory.primary
    ]
    
    static var primary: TextFieldStyle {
        get {
            return TextFieldStyle(backgroundColor: UIColor.white.withAlphaComponent(0.08), font: ThemeFonts.dynamicEquivalent(ofFont: ThemeFonts.latoLight, withSize: 15), textColor: .white, borderStyle: .roundedRect, tintColor: ThemeColors.maroon)
        }
    }
}

