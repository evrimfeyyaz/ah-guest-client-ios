//
//  Created by Evrim Persembe on 5/31/17.
//  Copyright © 2017 Automated Hotel. All rights reserved.
//

import Alamofire

class APIHeadersAdapter: RequestAdapter {
    let clientSecret = "2d99e2d3ee56721df0f21f2a38cda062d7cf929f714d957a60fce18ecae88643898ad3f41e19770f6ae16b495af667922c00b6104647b4f5d76a4a22cd9763b7"
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        
        urlRequest.setValue(clientSecret, forHTTPHeaderField: "ah-client-secret")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        return urlRequest
    }
}
