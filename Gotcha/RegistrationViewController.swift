//
//  RegistrationViewController.swift
//  Gotcha
//
//  Created by Don Miller on 2/15/18.
//  Copyright © 2018 GroundSpeed. All rights reserved.
//

import UIKit
import SwiftyJSON

class RegistrationViewController: UIViewController {

    @IBOutlet var txtName: UITextField!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var btnRegister: UIButton!
    @IBOutlet var btnCancel: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerPlayer(_ sender: Any) {

        RestAPIManager.sharedInstance.register(name: txtName.text!, email_address: txtEmail.text!, password: txtPassword.text!, type: Constants.PlayerType, onCompletion: { (json: JSON) in
            
            //TODO: Add validation error handling
            
            let player : Player? = Player(json: json["data"])
            GlobalState.AuthenticatedUser = true
            GlobalState.Player = player!
            
            if GlobalState.AuthenticatedUser {
                self.dismiss(animated: true, completion: nil)
            }
        })
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
