//
//  ArenaListViewController.swift
//  Gotcha
//
//  Created by Don Miller on 2/24/18.
//  Copyright © 2018 GroundSpeed. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreLocation

class ArenaListViewController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tblArenas: UITableView!
    var _arenas : [Arena] = []
    let _locationManager = CLLocationManager()
    var _longitude : CLLocationDegrees = 0.0
    var _latitude : CLLocationDegrees = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tblArenas.delegate = self
        self.tblArenas.dataSource = self

        getCurrentLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getArenas() {
        // "39.7799642, -86.272832"
        RestAPIManager.sharedInstance.getArenas(latitude: String(_latitude), longitude: String(_longitude), onCompletion: { (json: JSON) in
            
            self._arenas = []
            for item in json["data"].arrayValue
            {
                self._arenas.append(Arena(json: item))
            }
            
            DispatchQueue.main.async {
                self.tblArenas.reloadData()
            }
        })
    }
    
    //MARK: Geolocation
    func getCurrentLocation() {
        self._locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            _locationManager.delegate = self
            _locationManager.desiredAccuracy = kCLLocationAccuracyBest
            _locationManager.startUpdatingLocation()
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        _longitude = locValue.longitude
        _latitude = locValue.latitude
        _locationManager.stopUpdatingLocation()
        
        DispatchQueue.main.async {
            self.getArenas()
        }
    }
    
    //MARK: Table Info
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self._arenas.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "arena", for: indexPath)
        let arenaAttributes = self._arenas[indexPath.row].attributes

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
