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
	var attributes : Attributes?

	required init(json: JSON) {
		id = json["id"].intValue
		type = json["type"].stringValue
        if (json["attributes"] != JSON.null) {
            attributes = Attributes(json: json["attributes"])
        }
	}
    
    required init(id: Int?, type: String?, attributes : Attributes?) {
        self.id = id
        self.type = type
        self.attributes = attributes
    }
}
