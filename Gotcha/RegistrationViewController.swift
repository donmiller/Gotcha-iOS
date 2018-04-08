//
//  RegistrationViewController.swift
//  Gotcha
//
//  Created by Don Miller on 2/15/18.
//  Copyright © 2018 GroundSpeed. All rights reserved.
//

import UIKit
import SwiftyJSON
import Photos

class RegistrationViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var imgAvatar: UIImageView!
    @IBOutlet var btnAvatar: UIButton!
    @IBOutlet var txtName: UITextField!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var btnRegister: UIButton!
    @IBOutlet var btnCancel: UIButton!

    var imagePicker: UIImagePickerController!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        makePretty()
    }

    func makePretty() {
        imgAvatar.circleWithBorder(color: UIColor.gotchaPurple.cgColor)
        btnRegister.rounded(color: UIColor.gotchaPurple)
        btnCancel.rounded(color: UIColor.gotchaPurple)
    }
    
    @IBAction func registerPlayer(_ sender: Any) {
        
        var avatar : String = ""
        if self.imgAvatar.image != UIImage(named: "Ninja-100.png") {
            let resizedImage = self.imgAvatar.image?.scaleImageWith(scaledToSize: 20)
            let imageData = UIImagePNGRepresentation(resizedImage!)
            let base64String = imageData!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
            avatar = base64String
        }

        PlayersEndpoint.sharedInstance.register(name: txtName.text!, email_address: txtEmail.text!, password: txtPassword.text!, type: Constants.PlayerType, avatar: avatar, onCompletion: { (json: JSON) in
            
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
    
    @IBAction func getAvatar(_ sender: Any) {
        
        self.imgAvatar.image = UIImage(named: "")
        
        let actionSheetController: UIAlertController = UIAlertController(title: "Take or Choose Avatar", message: nil, preferredStyle: .actionSheet)
        actionSheetController.view.tintColor = UIColor.gotchaPurple
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            self.imgAvatar.image = UIImage(named: "Ninja-100.png")
        }
        actionSheetController.addAction(cancelAction)
        
        let takePictureAction: UIAlertAction = UIAlertAction(title: "Take Picture", style: .default) { action -> Void in
            
            self.imagePicker = UIImagePickerController()
            self.imagePicker.delegate = self
            self.imagePicker.sourceType = .camera
            self.imagePicker.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        actionSheetController.addAction(takePictureAction)

        let choosePictureAction: UIAlertAction = UIAlertAction(title: "Choose From Camera Roll", style: .default) { action -> Void in
            
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
            
            self.present(pickerController, animated: true, completion: nil)
        }
        actionSheetController.addAction(choosePictureAction)

        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    //MARK: ImagePicker
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imgAvatar.contentMode = .scaleAspectFit
            imgAvatar.image = pickedImage
        }

        picker.dismiss(animated: true, completion: nil)
        
    }
    
}
