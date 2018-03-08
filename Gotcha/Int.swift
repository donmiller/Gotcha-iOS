//
//  Int.swift
//  Gotcha
//
//  Created by Don Miller on 3/8/18.
//  Copyright © 2018 GroundSpeed. All rights reserved.
//

import UIKit

extension Int {
    
    var toDate:Date {
        return Date(timeIntervalSince1970: (TimeInterval(self / 1000)))
    }
    
    var stringValue:String {
        return "\(self)"
    }
}

