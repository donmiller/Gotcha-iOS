//
//  ArenaListViewController.swift
//  Gotcha
//
//  Created by Don Miller on 2/24/18.
//  Copyright © 2018 GroundSpeed. All rights reserved.
//

import UIKit
import SwiftyJSON

class ArenaListViewController: UIViewController {

    var arenas : [Arena] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getArenas()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getArenas() {
        
        RestAPIManager.sharedInstance.getArenas(latitude: "39.7799642", longitude: "-86.272832", onCompletion: { (json: JSON) in
            
            for item in json["data"].arrayValue
            {
                self.arenas.append(Arena(json: item))
            }
            
            print(self.arenas)

        })
    }
    
}
