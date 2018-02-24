//
//  ArenaAttributes.swift
//  Gotcha
//
//  Created by Don Miller on 2/22/18.
//  Copyright © 2018 GroundSpeed. All rights reserved.
//

import SwiftyJSON

class ArenaAttributes {
    
	var location_name : String?
	var latitude : Double?
	var longitude : Double?
	var street_address1 : String?
	var street_address2 : String?
	var city : String?
	var state : String?
	var zip_code : Int?

	required init(json: JSON) {

		location_name = json["location_name"].stringValue
		latitude = json["latitude"].doubleValue
		longitude = json["longitude"].doubleValue
		street_address1 = json["street_address1"].stringValue
		street_address2 = json["street_address2"].stringValue
		city = json["city"].stringValue
		state = json["state"].stringValue
		zip_code = json["zip_code"].intValue
	}
}
