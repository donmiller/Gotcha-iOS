//
//  ArenaViewController.swift
//  Gotcha
//
//  Created by Don Miller on 4/7/18.
//  Copyright © 2018 GroundSpeed. All rights reserved.
//

import UIKit
import SwiftyJSON

class ArenaViewController: UIViewController {

    @IBOutlet var lblArenaName: UILabel!
    @IBOutlet var lblCompetitorAvatar: UIImageView!
    @IBOutlet var lblCompetitorName: UILabel!
    @IBOutlet var btnCapture: UIButton!
    @IBOutlet var btnLeaveArena: UIButton!
    @IBOutlet var viewMatch: UIView!
    @IBOutlet var viewWaiting: UIView!
    
    var arena : Arena?
    
    override func viewDidAppear(_ animated: Bool) {
        if self.isNotAuthenticated() {
            performSegue(withIdentifier: "unwindToLogin", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblArenaName.text = arena?.locationName!
        makePretty()
    }
    
    func makePretty() {
        btnCapture.rounded(color: UIColor.gotchaPurple)
        btnLeaveArena.rounded(color: UIColor.gotchaPurple)
        viewWaiting.isHidden = false
        viewMatch.isHidden = true
    }
    
    @IBAction func leaveArena() {
        ArenasEndpoint.sharedInstance.leaveArena(arena: (GlobalState.Arena?.id)!, onCompletion: { (json: JSON) in
            
            GlobalState.Arena = nil
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        })
    }
    
    @IBAction func nextMatch() {
        MatchesEndpoint.sharedInstance.newMatch(arena: (GlobalState.Arena?.id)!, onCompletion: { (json: JSON) in
            
            print(json)
            
        })
    }
}
