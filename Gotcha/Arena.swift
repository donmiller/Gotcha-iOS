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
    var locationName : String?
    var latitude : Double?
    var longitude : Double?
    var streetAddress1 : String?
    var streetAddress2 : String?
    var city : String?
    var state : String?
    var zipCode : Int?
    
	required init(json: JSON) {
		id = json["id"].intValue
		type = json["type"].stringValue
        if (json["attributes"] != JSON.null) {
            var attributes = json["attributes"]
            locationName = attributes["location_name"].stringValue
            latitude = attributes["latitude"].doubleValue
            longitude = attributes["longitude"].doubleValue
            streetAddress1 = attributes["street_address1"].stringValue
            streetAddress2 = attributes["street_address2"].stringValue
            city = attributes["city"].stringValue
            state = attributes["state"].stringValue
            zipCode = attributes["zip_code"].intValue
        }
	}
}
