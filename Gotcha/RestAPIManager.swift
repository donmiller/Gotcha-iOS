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

        makeHTTPPostRequest(path: route, body: body, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    func login(email_address: String, password: String, onCompletion: @escaping (JSON) -> Void)
    {
        let route = Constants.BaseUrl + "/sessions"
        var body: [String: Any] {
            return ["data": ["attributes": ["email_address": email_address, "password": password]]]
        }
        
        makeHTTPPostRequest(path: route, body: body, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    func getArenas(latitude: String, longitude: String, onCompletion: @escaping (JSON) -> Void)
    {
        let route = Constants.BaseUrl + "/arenas?latitude=\(latitude)&longitude=\(longitude)"
        
        makeHTTPGetRequest(path: route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    // MARK: GET AND POST REQUESTS
    private func makeHTTPPostRequest(path: String, body: [String: Any], onCompletion: @escaping ServiceResponse) {
        var request = URLRequest(url: URL(string: path)!)
        request.httpMethod = "POST"
        
        do {
            let jsonBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)

            request.addValue("application/vnd.api+json", forHTTPHeaderField: "Content-Type")
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
            onCompletion(JSON.null, nil)
        }
    }
    
    private func makeHTTPGetRequest(path: String, onCompletion: @escaping ServiceResponse) {
        var request = URLRequest(url: URL(string: path)!)
        request.httpMethod = "GET"
        request.addValue("application/vnd.api+json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/vnd.api+json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(GlobalState.api_token)", forHTTPHeaderField: "Authorization")
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
    }

}
