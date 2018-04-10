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
    var apiKey : String?
    var avatar : String?
    var emailAddress : String?
    var name : String?
    var password : String?

	required init(json: JSON) {
		id = json["id"].intValue
		type = json["type"].stringValue
        if (json["attributes"] != JSON.null) {
            var attributes = json["attributes"]
            apiKey = attributes["api_key"].stringValue
            avatar = attributes["avatar"]["url"].stringValue
            emailAddress = attributes["email_address"].stringValue
            name = attributes["name"].stringValue
            password = attributes["password"].stringValue
        }
	}
    
    required init(id: Int?, type: String?, apiKey: String?, avatar: String?, emailAddress: String?, name: String?, password: String?) {
        self.id = id
        self.type = type
        self.apiKey = apiKey
        self.avatar = avatar
        self.emailAddress = emailAddress
        self.name = name
        self.password = password
    }
}
