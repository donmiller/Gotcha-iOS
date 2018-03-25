//
//  UIApplication.swift
//  Gotcha
//
//  Created by Don Miller on 3/8/18.
//  Copyright © 2018 GroundSpeed. All rights reserved.
//

import UIKit

extension UIApplication {
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}

