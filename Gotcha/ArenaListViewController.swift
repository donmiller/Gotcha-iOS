//
//  ArenaListViewController.swift
//  Gotcha
//
//  Created by Don Miller on 2/24/18.
//  Copyright © 2018 GroundSpeed. All rights reserved.
//

import UIKit
import SwiftyJSON

class ArenaListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tblArenas: UITableView!
    var arenas : [Arena] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tblArenas.delegate = self
        self.tblArenas.dataSource = self

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
            
            DispatchQueue.main.async {
                self.tblArenas.reloadData()
            }
        })
    }
    
    //MARK: Table Info
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arenas.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "arena", for: indexPath)
        let arenaAttributes = self.arenas[indexPath.row].attributes

        let locationName = cell.contentView.viewWithTag(10) as! UILabel
        locationName.text = arenaAttributes?.location_name
        
        let address1 = cell.contentView.viewWithTag(20) as! UILabel
        address1.text = arenaAttributes?.street_address1
        
        let cityStateZip = cell.contentView.viewWithTag(30) as! UILabel
        cityStateZip.text = arenaAttributes?.city!
        cityStateZip.text?.append(", ")
        cityStateZip.text?.append((arenaAttributes?.state)!)
        cityStateZip.text?.append(" ")
        cityStateZip.text?.append((arenaAttributes?.zip_code?.stringValue)!)
        
        return cell
    }
    
}
