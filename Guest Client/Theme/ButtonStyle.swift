//
//  Created by Evrim Persembe on 6/11/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

struct ButtonStyle {
    let cornerRadius: CGFloat
    let borderWidth: CGFloat
    let backgroundColor: UIColor
    let borderColor: UIColor
    let tintColor: UIColor
    let contentEdgeInsets: UIEdgeInsets
}

class ButtonStyleFactory {
    static let styles = [
        "primary": ButtonStyleFactory.primary,
        "secondary": ButtonStyleFactory.secondary
    ]
    
    static var primary: ButtonStyle {
        get {
            return ButtonStyle(cornerRadius: 5,
                               borderWidth: 0,
                               backgroundColor: ThemeColors.maroon,
                               borderColor: .clear,
                               tintColor: .white,
                               contentEdgeInsets: UIEdgeInsets(top: 10, left: 25, bottom: 10, right: 25))
        }
    }
    
    static var secondary: ButtonStyle {
        get {
            return ButtonStyle(cornerRadius: 5,
                               borderWidth: 1,
                               backgroundColor: .clear,
                               borderColor: .white,
                               tintColor: .white,
                               contentEdgeInsets: UIEdgeInsets(top: 10, left: 25, bottom: 10, right: 25))
        }
    }
}
