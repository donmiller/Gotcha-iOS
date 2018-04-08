//
//  ArenaAttributes.swift
//  Gotcha
//
//  Created by Don Miller on 2/22/18.
//  Copyright © 2018 GroundSpeed. All rights reserved.
//

import SwiftyJSON

class ArenaAttributes {
    
	var locationName : String?
	var latitude : Double?
	var longitude : Double?
	var streetAddress1 : String?
	var streetAddress2 : String?
	var city : String?
	var state : String?
	var zipCode : Int?
    var joinedAt : Double?

	required init(json: JSON) {

		locationName = json["location_name"].stringValue
		latitude = json["latitude"].doubleValue
		longitude = json["longitude"].doubleValue
		streetAddress1 = json["street_address1"].stringValue
		streetAddress2 = json["street_address2"].stringValue
		city = json["city"].stringValue
		state = json["state"].stringValue
		zipCode = json["zip_code"].intValue
        joinedAt = json["joined_at"].doubleValue
	}
}
