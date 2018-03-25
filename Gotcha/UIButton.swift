//
//  UIButton.swift
//  Gotcha
//
//  Created by Don Miller on 3/8/18.
//  Copyright © 2018 GroundSpeed. All rights reserved.
//

import UIKit

extension UIButton {
    
    func rounded(color: UIColor) {
        self.layer.cornerRadius = self.bounds.height / 2
        self.layer.masksToBounds = true
        self.backgroundColor = color
    }
    
    func whiteRounded() {
        self.rounded(color: .clear)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
    }
}

