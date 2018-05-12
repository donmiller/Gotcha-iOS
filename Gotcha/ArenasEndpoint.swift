//
//  ArenasEndpoint.swift
//  Gotcha
//
//  Created by Don Miller on 4/8/18.
//  Copyright © 2018 GroundSpeed. All rights reserved.
//

import SwiftyJSON

class ArenasEndpoint {

    static let sharedInstance = ArenasEndpoint()
    let route = Constants.BaseUrl + "/arenas"
    
    func getArenas(latitude: String, longitude: String, onCompletion: @escaping (JSON) -> Void)
    {
        let path = route + "?latitude=\(latitude)&longitude=\(longitude)"
        
        RestAPIManager.sharedInstance.makeHTTPGetRequest(path: path, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    func enterArena(arena: Int, onCompletion: @escaping (JSON) -> Void)
    {
        let path = route + "/\(arena)/play"
        
        RestAPIManager.sharedInstance.makeHTTPPostRequest(path: path, body: [:], authRequired: true, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    func leaveArena(arena: Int, onCompletion: @escaping (JSON) -> Void)
    {
        let path = route + "/\(arena)/leave"
        
        RestAPIManager.sharedInstance.makeHTTPPostRequest(path: path, body: [:], authRequired: true, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
}
