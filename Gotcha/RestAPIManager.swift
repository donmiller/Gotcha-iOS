//
//  RestAPIManager.swift
//  Gotcha
//
//  Created by Don Miller on 2/9/18.
//  Copyright © 2018 GroundSpeed. All rights reserved.
//

import UIKit
import SwiftyJSON

typealias ServiceResponse = (JSON, NSError?) -> Void

class RestAPIManager: NSObject {
    
    static let sharedInstance = RestAPIManager()
    
    func register(name: String, email_address: String, password: String, type: String, onCompletion: @escaping (JSON) -> Void)
    {
        let route = Constants.BaseUrl + "/players"
        var body: [String: Any] {
            return ["data": ["type": type,
                    "attributes": ["email_address": email_address, "name": name, "password": password]]]
        }
        //let body = "{\"data\":{\"type\":\"\(type)\",\"attributes\":{\"email_address\":\"\(email_address)\",\"password\":\"\(password)\"}}}"
        
        makeHTTPPostRequest(path: route, body: body, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
        
    // MARK: GET AND POST REQUESTS
    private func makeHTTPPostRequest(path: String, body: [String: Any], onCompletion: @escaping ServiceResponse) {
        var request = URLRequest(url: URL(string: path)!)
        // Set the method to POST
        request.httpMethod = "POST"
        
        do {
            //TODO: Remove these if Jamie doesn't implement Basic Auth
            //let loginString = String(format: "%@:%@", Constants.ClientId, Constants.ClientSecret)
            //let loginData = loginString.data(using: String.Encoding.utf8)!
            //let base64LoginString = loginData.base64EncodedString()
            
            let jsonBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
            // Set the POST body for the request
            request.addValue("application/vnd.api+json", forHTTPHeaderField: "Content-Type")
            //request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
            request.httpBody = jsonBody
            let session = URLSession.shared
            
            let task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in

                do {
                    if let jsonData = data {
                        let json:JSON = try JSON(data: jsonData)
                        print(json)
                        onCompletion(json, nil)
                    } else {
                        onCompletion(JSON.null, error as NSError?)
                    }
                } catch let error as NSError {
                    print(error)
                }
                
            })
            task.resume()
        } catch {
            // Create your personal error
            onCompletion(JSON.null, nil)
        }
    }
}
