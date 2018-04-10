//
//  ArenaViewController.swift
//  Gotcha
//
//  Created by Don Miller on 4/7/18.
//  Copyright © 2018 GroundSpeed. All rights reserved.
//

import UIKit
import SwiftyJSON

class PlayerWaitingViewController: UIViewController {

    @IBOutlet var lblArenaName: UILabel!
    @IBOutlet var viewWaiting: UIView!
    @IBOutlet var imgPlayerAvatar: UIImageView!
    @IBOutlet var lblPlayerName: UILabel!
    @IBOutlet var lblPlayerRank: UILabel!
    @IBOutlet var lblPlayerPoints: UILabel!
    @IBOutlet var btnLeaveArena: UIButton!
    
    var arena : Arena?
    
//    override func viewDidAppear(_ animated: Bool) {
//        if self.isNotAuthenticated() {
//            performSegue(withIdentifier: "unwindToLogin", sender: self)
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblArenaName.text = arena?.locationName!
        makePretty()
        loadPlayer()
    }
    
    func makePretty() {
        btnLeaveArena.rounded(color: UIColor.gotchaPurple)
        imgPlayerAvatar.circleWithBorder(color: UIColor.gotchaPurple.cgColor)
    }
    
    func loadPlayer() {
        lblPlayerName.text = GlobalState.Player?.name!
        lblPlayerRank.text = "#1"
        lblPlayerPoints.text = "150"
        imgPlayerAvatar.downloadedFrom(link: (GlobalState.Player?.avatar!)!)
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
