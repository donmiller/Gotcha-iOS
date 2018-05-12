//
//  ScoresEndpoint.swift
//  Gotcha
//
//  Created by Don Miller on 5/9/18.
//  Copyright © 2018 GroundSpeed. All rights reserved.
//

import SwiftyJSON

class ScoresEndpoint {
    
    static let sharedInstance = ScoresEndpoint()
    let route = Constants.BaseUrl + "/scores"
    
    func getScores(playerId: Int, arenaId: Int, onCompletion: @escaping (JSON) -> Void)
    {
        let path = route + "?filter[player]=\(playerId)&filter[arena]=\(arenaId)"
        
        RestAPIManager.sharedInstance.makeHTTPGetRequest(path: path, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
}
