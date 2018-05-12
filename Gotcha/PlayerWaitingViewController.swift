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
        imgPlayerAvatar.downloadedFrom(link: (GlobalState.Player?.avatar!)!)
        
        ScoresEndpoint.sharedInstance.getScores(playerId: (GlobalState.Player?.id)!,
                                                arenaId: (arena?.id)!,
                                                onCompletion: { (json: JSON) in
            let score = Score(json: json["meta"])
            DispatchQueue.main.async {
                self.lblPlayerPoints.text = String(describing: score.totalPoints!)
                self.lblPlayerRank.text = score.placement
            }
        })
        
    }
    
    @IBAction func leaveArena() {
        ArenasEndpoint.sharedInstance.leaveArena(arena: (GlobalState.Arena?.id)!, onCompletion: { (json: JSON) in
            
            GlobalState.Arena = nil
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        })
    }    
}
