//
//  UIImageView.swift
//  Gotcha
//
//  Created by Don Miller on 3/8/18.
//  Copyright © 2018 GroundSpeed. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func changeTintColor(imageName:String, tintColor:UIColor) {
        let nameImage = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        self.image = nameImage
        self.tintColor = tintColor
    }
    
    func circleWithBorder(color: CGColor) {
        self.layer.borderWidth = 2.0
        self.layer.borderColor = color
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.size.width/2
        self.clipsToBounds = true

    }
}
