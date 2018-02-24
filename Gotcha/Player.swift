//
//  Player.swift
//  Gotcha
//
//  Created by Don Miller on 2/10/18.
//  Copyright © 2018 GroundSpeed. All rights reserved.
//

import SwiftyJSON

class Player {
	var id : Int?
	var type : String?
	var attributes : PlayerAttributes?

	required init(json: JSON) {
		id = json["id"].intValue
		type = json["type"].stringValue
        if (json["attributes"] != JSON.null) {
            attributes = PlayerAttributes(json: json["attributes"])
        }
	}
    
    required init(id: Int?, type: String?, attributes : PlayerAttributes?) {
        self.id = id
        self.type = type
        self.attributes = attributes
    }
}
