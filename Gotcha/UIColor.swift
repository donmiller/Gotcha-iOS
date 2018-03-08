//
//  UIColor.swift
//  Gotcha
//
//  Created by Don Miller on 3/8/18.
//  Copyright © 2018 GroundSpeed. All rights reserved.
//

import UIKit

extension UIColor {
    static let gotchaRed : UIColor = UIColor.init(hex: "#ef3e42")
    static let gotchaBlueColor : UIColor = UIColor.init(hex: "#c9e9ee")
    static let gotchaYellowColor : UIColor = UIColor.init(hex: "#fbb034")
    static let gotchaGreenRedColor : UIColor = UIColor.init(hex: "#b4d88b")
    static let gotchaBlackColor : UIColor = UIColor.init(hex: "#231f20")
    static let gotchaDarkGrayColor : UIColor = UIColor.init(hex: "#424143")
    static let gotchaGrayColor : UIColor = UIColor.init(hex: "#807f83")
    static let gotchaWhiteColor : UIColor = UIColor.init(hex: "#ffffff")
    
    convenience init(colorWithHexValue value: Int, alpha:CGFloat = 1.0){
        self.init(
            red: CGFloat((value & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((value & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(value & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
    
    convenience init(hex: String, alpha:CGFloat = 1.0){
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

