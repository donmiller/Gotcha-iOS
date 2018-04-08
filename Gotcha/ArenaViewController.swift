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
    
    var arena : ArenaAttributes?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblArenaName.text = arena?.locationName!
        makePretty()
    }
    
    func makePretty() {
        btnNext.rounded(color: UIColor.gotchaGreenRedColor)
        btnCapture.rounded(color: UIColor.gotchaGreenRedColor)
    }
    
    @IBAction func leaveArena() {
        RestAPIManager.sharedInstance.leaveArena(arena: (GlobalState.Arena?.id)!, onCompletion: { (json: JSON) in
            
            print(json)
            GlobalState.Arena = nil
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        })
    }
}
