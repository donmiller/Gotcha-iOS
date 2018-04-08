//
//  Attributes.swift
//  Gotcha
//
//  Created by Don Miller on 2/10/18.
//  Copyright © 2018 GroundSpeed. All rights reserved.
//

import SwiftyJSON

class PlayerAttributes {

    var apiKey : String?
	var avatar : String?
	var emailAddress : String?
	var name : String?
	var password : String?

	required init(json: JSON) {
		apiKey = json["api_key"].stringValue
		avatar = json["avatar"].stringValue
		emailAddress = json["email_address"].stringValue
		name = json["name"].stringValue
		password = json["password"].stringValue
	}
    
    required init(apiKey: String?, avatar: String?, emailAddress: String?, name: String?, password: String?) {
        self.apiKey = apiKey
        self.avatar = avatar
        self.emailAddress = emailAddress
        self.name = name
        self.password = password
    }
}
