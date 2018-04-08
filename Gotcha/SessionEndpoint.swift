//
//  SessionEndpoint.swift
//  Gotcha
//
//  Created by Don Miller on 4/8/18.
//  Copyright © 2018 GroundSpeed. All rights reserved.
//

import SwiftyJSON

class SessionEndpoint {

    static let sharedInstance = SessionEndpoint()
    let route = Constants.BaseUrl + "/sessions"
    
    func login(email_address: String, password: String, onCompletion: @escaping (JSON) -> Void)
    {
        var body: [String: Any] {
            return ["data": ["attributes": ["email_address": email_address, "password": password]]]
        }
        
        RestAPIManager.sharedInstance.makeHTTPPostRequest(path: route, body: body, authRequired: false, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
}
