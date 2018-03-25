//
//  UITextField.swift
//  Gotcha
//
//  Created by Don Miller on 3/8/18.
//  Copyright © 2018 GroundSpeed. All rights reserved.
//

import UIKit

extension UITextField {
    
    func underlined(color: CGColor) {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = color
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    
    func transparentUnderlined(color: CGColor) {
        let border = CALayer()
        let width = CGFloat(0.5)
        border.borderWidth = width
        border.borderColor = color
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height)
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}

