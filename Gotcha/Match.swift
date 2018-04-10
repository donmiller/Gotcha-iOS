//
//  Match.swift
//  Gotcha
//
//  Created by Don Miller on 4/7/18.
//  Copyright © 2018 GroundSpeed. All rights reserved.
//

import UIKit
import SwiftyJSON

class Match {

    var id : Int
    var foundAt: Double?
    var matchedAt: Double?
    var arena: Int?
    var opponent: Int?
    var seeker: Int?
    
    required init(json: JSON) {
        
        id = json["id"].intValue
        if (json["attributes"] != JSON.null) {
            var attributes = json["attributes"]
            foundAt = attributes["found_at"].doubleValue
            matchedAt = attributes["matched_at"].doubleValue
        }
        if (json["relationships"] != JSON.null) {
            var relationships = json["relationships"]
            if (relationships["arena"] != JSON.null) {
                arena = relationships["arena"]["data"]["id"].intValue
            }
            if (relationships["opponent"] != JSON.null) {
                opponent = relationships["opponent"]["data"]["id"].intValue
            }
            if (relationships["seeker"] != JSON.null) {
                seeker = relationships["seeker"]["data"]["id"].intValue
            }
        }
    }
}
