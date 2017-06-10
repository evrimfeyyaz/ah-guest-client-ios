//
//  Created by Evrim Persembe on 6/10/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import Foundation

enum APIManagerError: Error {
    case clientAuthenticationFailed(reason: String)
    case jsonSerialization(reason: String)
}
