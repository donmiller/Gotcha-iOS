//
//  Arena.swift
//  Gotcha
//
//  Created by Don Miller on 2/22/18.
//  Copyright © 2018 GroundSpeed. All rights reserved.
//

import SwiftyJSON
 
class Arena {
	var id : Int?
	var type : String?
	var attributes : ArenaAttributes?

	required init(json: JSON) {

		id = json["id"].intValue
		type = json["type"].stringValue
        if (json["attributes"] != JSON.null) {
            attributes = ArenaAttributes(json: json["attributes"])
        }
	}
}
