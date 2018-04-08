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
    @IBOutlet var btnNext: UIButton!
    @IBOutlet var btnCapture: UIButton!
    @IBOutlet var btnLeaveArena: UIButton!
    @IBOutlet var viewOpponent: UIView!
    @IBOutlet var viewWaiting: UIView!
    
    var arena : Arena?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblArenaName.text = arena?.locationName!
        makePretty()
    }
    
    func makePretty() {
        btnNext.rounded(color: UIColor.gotchaPurple)
        btnCapture.rounded(color: UIColor.gotchaPurple)
        btnLeaveArena.rounded(color: UIColor.gotchaPurple)
        viewWaiting.isHidden = false
        viewOpponent.isHidden = true
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
