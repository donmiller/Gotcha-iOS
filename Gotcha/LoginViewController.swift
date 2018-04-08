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
        makePretty()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if GlobalState.Player?.attributes?.apiKey != nil {
            self.performSegue(withIdentifier: "authenticated", sender: nil)
        }
    }

    func makePretty() {
        btnLogin.rounded(color: UIColor.gotchaGreenRedColor)
    }
    
    @IBAction func login(_ sender: Any) {
        loginPlayer()    
    }
    
    func loginPlayer() {
        RestAPIManager.sharedInstance.login(email_address: txtEmail.text!, password: txtPassword.text!, onCompletion: { (json: JSON) in
            
            let player : Player? = Player(json: json["data"])
            
            if (player?.attributes?.apiKey != nil) {
                GlobalState.AuthenticatedUser = true
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
        if identifier == "register" {
            return true
        } else if identifier == "authenticated" {
            return GlobalState.Player?.attributes?.apiKey! != nil
        } else {
            return false
        }
        
    }
}

