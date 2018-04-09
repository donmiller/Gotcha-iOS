//
//  PlayersEndpoint.swift
//  Gotcha
//
//  Created by Don Miller on 4/8/18.
//  Copyright © 2018 GroundSpeed. All rights reserved.
//

import SwiftyJSON

class PlayersEndpoint {

    static let sharedInstance = PlayersEndpoint()
    let route = Constants.BaseUrl + "/players"

    func register(name: String, email_address: String, password: String, type: String, avatar: String, onCompletion: @escaping (JSON) -> Void)
    {
        var body: [String: Any] {
            return ["data": ["type": type,
                             "attributes": ["email_address": email_address, "name": name, "password": password, "avatar": avatar]]]
        }
        
        RestAPIManager.sharedInstance.makeHTTPPostRequest(path: route, body: body, authRequired: false, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
}
