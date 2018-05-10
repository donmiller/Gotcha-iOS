//
//  DevicesEndpoint.swift
//  Gotcha
//
//  Created by Don Miller on 4/8/18.
//  Copyright © 2018 GroundSpeed. All rights reserved.
//

import SwiftyJSON

class DevicesEndpoint {

    static let sharedInstance = DevicesEndpoint()
    let route = Constants.BaseUrl + "/devices"
    
    func registerDevice(deviceToken: String, onCompletion: @escaping (JSON) -> Void)
    {
        var body: [String: Any] {
            return ["data": ["type": "device", "attributes": ["token": deviceToken]]]
        }
        
        RestAPIManager.sharedInstance.makeHTTPPostRequest(path: route, body: body, authRequired: true, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }

}
