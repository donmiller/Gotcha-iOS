//
//  ConfirmCaptureViewController.swift
//  Gotcha
//
//  Created by Don Miller on 5/13/18.
//  Copyright © 2018 GroundSpeed. All rights reserved.
//

import UIKit
import SwiftyJSON

class ConfirmCaptureViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var btnSubmit: UIButton!
    @IBOutlet var txtFirstDigit: UITextField!
    @IBOutlet var txtSecondDigit: UITextField!
    @IBOutlet var txtThirdDigit: UITextField!
    @IBOutlet var txtFourthDigit: UITextField!
    var arena: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makePretty()
        setupTextFields()
        self.hideKeyboardWhenTappedAround()
    }

    func setupTextFields() {
        txtFirstDigit.delegate = self
        txtSecondDigit.delegate = self
        txtThirdDigit.delegate = self
        txtFourthDigit.delegate = self
        
        txtFirstDigit.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        txtSecondDigit.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        txtThirdDigit.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        txtFourthDigit.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
    }
    
    @objc func textFieldDidChange(textField: UITextField){
        let text = textField.text
        if  text?.count == 1 {
            switch textField{
            case txtFirstDigit:
                txtSecondDigit.becomeFirstResponder()
            case txtSecondDigit:
                txtThirdDigit.becomeFirstResponder()
            case txtThirdDigit:
                txtFourthDigit.becomeFirstResponder()
            case txtFourthDigit:
                txtFourthDigit.resignFirstResponder()
            default:
                break
            }
        }
        if  text?.count == 0 {
            switch textField{
            case txtFirstDigit:
                txtFirstDigit.becomeFirstResponder()
            case txtSecondDigit:
                txtFirstDigit.becomeFirstResponder()
            case txtThirdDigit:
                txtSecondDigit.becomeFirstResponder()
            case txtFourthDigit:
                txtThirdDigit.becomeFirstResponder()
            default:
                break
            }
        }
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
