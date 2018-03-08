//
//  UIView.swift
//  Gotcha
//
//  Created by Don Miller on 3/8/18.
//  Copyright © 2018 GroundSpeed. All rights reserved.
//

import UIKit

extension UIView {
    
    func roundRedCorner() {
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.borderWidth = 1.5
        self.layer.cornerRadius = 5
    }
    
    func roundCorner() {
        self.layer.borderColor = self.layer.backgroundColor
        self.layer.borderWidth = 1.5
        self.layer.cornerRadius = 10
    }
    
    func makeCircle() {
        self.layer.cornerRadius = self.bounds.height / 2
        self.layer.masksToBounds = true
    }
    
    func thinRedBox() {
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.borderWidth = 1
    }
}

