//
//  Score.swift
//  Gotcha
//
//  Created by Don Miller on 4/9/18.
//  Copyright © 2018 GroundSpeed. All rights reserved.
//

import SwiftyJSON

class Score {
    var totalPoints: Int?
    var placement: String?
    
    init(json: JSON) {
        totalPoints = json["total_points"].intValue
        placement = json["placement"].stringValue
    }
}
