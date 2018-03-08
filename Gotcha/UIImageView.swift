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
}
