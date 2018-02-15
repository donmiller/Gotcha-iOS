//
//  Attributes.swift
//  Gotcha
//
//  Created by Don Miller on 2/10/18.
//  Copyright © 2018 GroundSpeed. All rights reserved.
//

import SwiftyJSON

class Attributes {

    var api_key : String?
	var avatar : String?
	var email_address : String?
	var name : String?
	var password : String?

	required init(json: JSON) {
		api_key = json["api_key"].stringValue
		avatar = json["avatar"].stringValue
		email_address = json["email_address"].stringValue
		name = json["name"].stringValue
		password = json["password"].stringValue
	}
    
    required init(api_key: String?, avatar: String?, email_address: String?, name: String?, password: String?) {
        self.api_key = api_key
        self.avatar = avatar
        self.email_address = email_address
        self.name = name
        self.password = password
    }
}
