//
//  ArenaViewController.swift
//  Gotcha
//
//  Created by Don Miller on 4/7/18.
//  Copyright © 2018 GroundSpeed. All rights reserved.
//

import UIKit

class ArenaViewController: UIViewController {

    @IBOutlet var lblArenaName: UILabel!
    @IBOutlet var lblCompetitorAvatar: UIImageView!
    @IBOutlet var lblCompetitorName: UILabel!
    @IBOutlet var btnNext: UIButton!
    @IBOutlet var btnCapture: UIButton!
    
    var arena : ArenaAttributes?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblArenaName.text = arena?.location_name!
        makePretty()
    }
    
    func makePretty() {
        btnNext.rounded(color: UIColor.gotchaGreenRedColor)
        btnCapture.rounded(color: UIColor.gotchaGreenRedColor)
    }    
}
