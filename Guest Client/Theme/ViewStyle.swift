//
//  Created by Evrim Persembe on 6/11/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import UIKit

struct ViewStyle {
    let backgroundColor: UIColor
}

class ViewStyleFactory {
    static let styles = [
        "defaultBackground": defaultBackground
    ]
    
    static var defaultBackground: ViewStyle {
        get {
            return ViewStyle(backgroundColor: ThemeImages.backgroundImage)
        }
    }
}
