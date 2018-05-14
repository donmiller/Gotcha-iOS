//
//  ConfirmCaptureViewController.swift
//  Gotcha
//
//  Created by Don Miller on 5/13/18.
//  Copyright © 2018 GroundSpeed. All rights reserved.
//

import UIKit
import SwiftyJSON

class ConfirmCaptureViewController: UIViewController {

    @IBOutlet var btnSubmit: UIButton!
    @IBOutlet var txtFirstDigit: UITextField!
    @IBOutlet var txtSecondDigit: UITextField!
    @IBOutlet var txtThirdDigit: UITextField!
    @IBOutlet var txtFourthDigit: UITextField!
    var arena: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makePretty()
    }

    func makePretty() {
        btnSubmit.rounded(color: UIColor.gotchaPurple)
    }
    
    func createCode() -> Int {
        let code: String = "\(txtFirstDigit.text ?? "0")\(txtSecondDigit.text ?? "0")\(txtThirdDigit.text ?? "0")\(txtFourthDigit.text ?? "0")"
        let digits: Int = Int(code)!
        
        return digits
    }
    
    @IBAction func confirmCapture(_ sender: Any) {
        
        MatchesEndpoint.sharedInstance.captured(match: arena, token: createCode(), onCompletion: { (json: JSON) in
            print(json)
        })
        
    }
}
