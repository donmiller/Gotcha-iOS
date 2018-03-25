//
//  Data.swift
//  Gotcha
//
//  Created by Don Miller on 3/25/18.
//  Copyright © 2018 GroundSpeed. All rights reserved.
//

import UIKit

extension Data {

    func toHexString() -> String {
        return self.map { String(format: "%02.2hhx", $0) }.joined()
    }
}
