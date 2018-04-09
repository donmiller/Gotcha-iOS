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

    @IBOutlet var viewMain: UIView!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var btnLogin: UIButton!
    @IBOutlet var lblRegistrationTitle: UILabel!
    @IBOutlet var btnRegistration: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()
        makePretty()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if GlobalState.Player?.apiKey != nil {
            self.performSegue(withIdentifier: "authenticated", sender: nil)
        } else {
            self.viewMain.isHidden = false
        }
    }
    
    func makePretty() {
        btnLogin.rounded(color: UIColor.gotchaPurple)
        lblRegistrationTitle.textColor = UIColor.gotchaPurple
        btnRegistration.setTitleColor(UIColor.gotchaPurple, for: .normal)
    }
    
    @IBAction func login(_ sender: Any) {
        loginPlayer()    
    }
    
    @IBAction func unwindSegue(_ sender: UIStoryboardSegue) {
        print(sender.source)
    }
    
    func loginPlayer() {
        SessionEndpoint.sharedInstance.login(email_address: txtEmail.text!, password: txtPassword.text!, onCompletion: { (json: JSON) in
            
            let player : Player? = Player(json: json["data"])
            
            if (player?.apiKey != nil) {
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
            self.viewMain.isHidden = true
            return true
        } else if identifier == "authenticated" {
            return GlobalState.Player?.apiKey! != nil
        } else {
            return false
        }
        
    }
}

