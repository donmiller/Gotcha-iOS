//
//  MatchesEndpoint.swift
//  Gotcha
//
//  Created by Don Miller on 4/8/18.
//  Copyright © 2018 GroundSpeed. All rights reserved.
//

import SwiftyJSON

class MatchesEndpoint {

    static let sharedInstance = MatchesEndpoint()
    let route = Constants.BaseUrl + "/matches"
    
    func newMatch(arena: Int, onCompletion: @escaping (JSON) -> Void)
    {
        var body: [String: Any] {
            return ["data": ["type": Constants.MatchType, "attributes": ["arena": "\(arena)"]]]
        }
        
        RestAPIManager.sharedInstance.makeHTTPPostRequest(path: route, body: body, authRequired: true, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    func captured(match: Int, token: Int, onCompletion: @escaping (JSON) -> Void)
    {
        var body: [String: Any] {
            return ["data": ["attributes": ["token": "\(token)"]]]
        }
        
        let path = route + "/\(match)/captured"
        
        RestAPIManager.sharedInstance.makeHTTPPostRequest(path: path, body: body, authRequired: true, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
}
