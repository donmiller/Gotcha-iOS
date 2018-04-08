//
//  RestAPIManager.swift
//  Gotcha
//
//  Created by Don Miller on 2/9/18.
//  Copyright © 2018 GroundSpeed. All rights reserved.
//

import SwiftyJSON

typealias ServiceResponse = (JSON, NSError?) -> Void

class RestAPIManager {
    
    static let sharedInstance = RestAPIManager()
    
    func makeHTTPGetRequest(path: String, onCompletion: @escaping ServiceResponse) {
        var request = URLRequest(url: URL(string: path)!)
        request.httpMethod = "GET"
        request.addValue("application/vnd.api+json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/vnd.api+json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \((GlobalState.Player?.apiKey)!)", forHTTPHeaderField: "Authorization")
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
    
    func makeHTTPPostRequest(path: String, body: [String: Any], authRequired: Bool, onCompletion: @escaping ServiceResponse) {
        var request = URLRequest(url: URL(string: path)!)
        request.httpMethod = "POST"
        
        do {
            request.addValue("application/vnd.api+json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/vnd.api+json", forHTTPHeaderField: "Accept")
            if authRequired {
                request.addValue((GlobalState.Player?.apiKey)!, forHTTPHeaderField: "Authorization")
            }
            let jsonBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
            request.httpBody = jsonBody
            let session = URLSession.shared
            
            let task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in

                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 204 { //No Content 
                        onCompletion(JSON.null, nil)
                    } else {
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
                    }
                }
                
            })
            task.resume()
        } catch {
            onCompletion(JSON.null, nil)
        }
    }
    
    func makeHTTPDeleteRequest(path: String, onCompletion: @escaping ServiceResponse) {
        var request = URLRequest(url: URL(string: path)!)
        request.httpMethod = "DELETE"
        
        request.addValue("application/vnd.api+json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/vnd.api+json", forHTTPHeaderField: "Accept")
        request.addValue((GlobalState.Player?.apiKey)!, forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 204 { //No Content
                    onCompletion(JSON.null, nil)
                } else {
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
                        onCompletion(JSON.null, nil)
                    }
                }
            }
            
        })
        task.resume()
    }
}
