//
//  MatchViewController.swift
//  Gotcha
//
//  Created by Don Miller on 4/9/18.
//  Copyright © 2018 GroundSpeed. All rights reserved.
//

import UIKit
import SwiftyJSON

class MatchViewController: UIViewController {

    @IBOutlet var lblArenaName: UILabel!
    @IBOutlet var viewMatch: UIView!
    @IBOutlet var imgOpponentAvatar: UIImageView!
    @IBOutlet var lblOpponentName: UILabel!
    @IBOutlet var lblOpponentRank: UILabel!
    @IBOutlet var lblOpponentPoints: UILabel!
    @IBOutlet var imgSeekerAvatar: UIImageView!
    @IBOutlet var lblSeekerName: UILabel!
    @IBOutlet var lblSeekerRank: UILabel!
    @IBOutlet var lblSeekerPoints: UILabel!
    @IBOutlet var btnCapture: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        makePretty()
        loadMatch()
    }
    
    func makePretty() {
        btnCapture.rounded(color: UIColor.gotchaPurple)
        imgOpponentAvatar.circleWithBorder(color: UIColor.gotchaPurple.cgColor)
        imgSeekerAvatar.circleWithBorder(color: UIColor.gotchaPurple.cgColor)
    }

    func loadMatch() {
        lblArenaName.text = GlobalState.Arena?.locationName!
        if GlobalState.Match != nil {
            //GET Opponent
            PlayersEndpoint.sharedInstance.getPlayer(id: (GlobalState.Match?.opponent!)!, onCompletion: { (json:JSON) in
                
                DispatchQueue.main.async {
                    let opponent = Player(json: json["data"])
                    self.imgOpponentAvatar.downloadedFrom(link: opponent.avatar!)
                    self.lblOpponentName.text = opponent.name!
                    self.lblOpponentRank.text = "#2"
                    self.lblOpponentPoints.text = "55"
                }
            })
            
            //GET Seeker
            PlayersEndpoint.sharedInstance.getPlayer(id: (GlobalState.Match?.seeker!)!, onCompletion: { (json:JSON) in
                
                DispatchQueue.main.async {
                    let opponent = Player(json: json["data"])
                    self.imgSeekerAvatar.downloadedFrom(link: opponent.avatar!)
                    self.lblSeekerName.text = opponent.name!
                    self.lblSeekerRank.text = "#2"
                    self.lblSeekerPoints.text = "55"
                }
            })
            
            //GET Scores
            ArenasEndpoint.sharedInstance.getScores(arena: (GlobalState.Match?.arena)!, onCompletion: { (json: JSON) in
                
//                let score = Score(json: json["meta"])
//                DispatchQueue.main.async {
//
//                }
                
            })

        }
    }

    @IBAction func capture(_ sender: Any) {
        
    }
}
