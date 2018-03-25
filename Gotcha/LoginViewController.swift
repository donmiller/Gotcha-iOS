//
//  ViewController.swift
//  Gotcha
//
//  Created by Don Miller on 2/1/18.
//  Copyright © 2018 GroundSpeed. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoginViewController: UIViewController {

    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(_ sender: Any) {

        RestAPIManager.sharedInstance.login(email_address: txtEmail.text!, password: txtPassword.text!, onCompletion: { (json: JSON) in
            
            let player : Player? = Player(json: json["data"])

            if (player?.attributes?.api_key != nil) {
                GlobalState.AuthenticatedUser = true
                GlobalState.api_token = (player?.attributes?.api_key)!
                GlobalState.Player = player!

                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "authenticated", sender: nil)
                }
                
            } else if json["errors"].count > 0 {
                var errorOut : String = ""
                
                for index in 0...json["errors"].count-1 {
                    errorOut.append(json["errors"][index].description)
                    errorOut.append("\n")
                }
                self.presentAlert("Invalid", message: errorOut)
                
            } else {
                self.presentAlert("Error", message: "Server error")
            }

        })
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return !GlobalState.api_token.isEmpty
    }
}

