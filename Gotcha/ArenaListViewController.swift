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
    var _longitude : CLLocationDegrees = 0.00
    var _latitude : CLLocationDegrees = 0.00
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(ArenaListViewController.getArenas), for: UIControlEvents.valueChanged)
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tblArenas.delegate = self
        self.tblArenas.dataSource = self
        registerDevice()
        getCurrentLocation()
        getArenas()
        self.tblArenas.addSubview(self.refreshControl)
    }
        
    //MARK: Geolocation
    func getCurrentLocation() {
        self._locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            self._locationManager.delegate = self
            self._locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self._locationManager.requestWhenInUseAuthorization()
            self._locationManager.startUpdatingLocation()
        } else {
            checkForLocationServices()
        }
    }
    
    @objc func checkForLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus()) {
            case .notDetermined, .restricted, .denied:
                self.presentAlert("Location Restricted", message: "Location Services are restricted. Please enable in Settings to see current temperature.")
            case .authorizedAlways, .authorizedWhenInUse:
                print("Location Access")
            }
        } else {
            print("Location services are not enabled")
            self.presentAlert("Location Services Disabled", message: "Location Services are not enabled. Please enable in Settings to see current temperature.")
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
        let arena = self._arenas[indexPath.row]

        let locationName = cell.contentView.viewWithTag(10) as! UILabel
        locationName.text = arena.locationName
        
        let address1 = cell.contentView.viewWithTag(20) as! UILabel
        address1.text = arena.streetAddress1
        
        let cityStateZip = cell.contentView.viewWithTag(30) as! UILabel
        cityStateZip.text = arena.city!
        cityStateZip.text?.append(", ")
        cityStateZip.text?.append((arena.state)!)
        cityStateZip.text?.append(" ")
        cityStateZip.text?.append((arena.zipCode?.stringValue)!)
        
        let enterArena = cell.contentView.viewWithTag(40) as! UIButton
        enterArena.setTitle("Enter Arena", for: .normal)
        enterArena.rounded(color: UIColor.gotchaPurple)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let arena = self._arenas[indexPath.row]
        enterArena(arena: self._arenas[indexPath.row].id!)
        _ = shouldPerformSegue(withIdentifier: "enterArena", sender: true)
        performSegue(withIdentifier: "enterArena", sender: arena)
    }

    //MARK: Navigations
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if let perform = sender as? Bool {
            return perform
        } else {
            return false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let arena = sender as? Arena,
            let destVC = segue.destination as? PlayerWaitingViewController {
            destVC.arena = arena
        }
    }
    
    //MARK: API Calls
    @objc func getArenas() {
        // "39.7799642, -86.272832"
        print(String(_latitude))
        print(String(_longitude))
        ArenasEndpoint.sharedInstance.getArenas(latitude: String(_latitude), longitude: String(_longitude), onCompletion: { (json: JSON) in
            
            self._arenas = []
            for item in json["data"].arrayValue
            {
                self._arenas.append(Arena(json: item))
            }
            
            DispatchQueue.main.async {
                self.tblArenas.reloadData()
                self.refreshControl.endRefreshing()
            }
        })
    }
    
    func enterArena(arena: Int) {
        ArenasEndpoint.sharedInstance.enterArena(arena: arena, onCompletion: { (json: JSON) in
            print(json)
            GlobalState.Arena = Arena(json: json["data"])
        })
    }
    
    func registerDevice() {
        DevicesEndpoint.sharedInstance.registerDevice(deviceToken: GlobalState.DeviceToken, onCompletion: { (json: JSON) in
            print(json)
            
        })
    }
    
    @IBAction func logout() {
        SessionEndpoint.sharedInstance.logout(onCompletion: { (json: JSON) in
            print(json)
        })
        dismiss(animated: true, completion: nil)
    }
}
