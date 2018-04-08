//
//  UIImage.swift
//  Gotcha
//
//  Created by Don Miller on 4/8/18.
//  Copyright © 2018 GroundSpeed. All rights reserved.
//

import UIKit

extension UIImage {

    func scaleImageWith(scaledToSize factor:CGFloat) -> UIImage {
        
        let newWidth : CGFloat = self.size.width/factor
        let newHeight : CGFloat = self.size.height/factor
        let scaledSize : CGSize = CGSize(width: newWidth, height: newHeight)
        UIGraphicsBeginImageContextWithOptions(scaledSize, false, 0.0);
        self.draw(in: CGRect(x: 0, y: 0, width: scaledSize.width, height: scaledSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
}
