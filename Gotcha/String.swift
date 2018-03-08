//
//  String.swift
//  Gotcha
//
//  Created by Don Miller on 3/8/18.
//  Copyright © 2018 GroundSpeed. All rights reserved.
//

import UIKit

extension String {
    
    var toDoubleFromCurrency:Double {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        
        if formatter.number(from: self) != nil {
            return formatter.number(from: self)?.doubleValue ?? 0
        }
        
        formatter.numberStyle = .decimal
        if formatter.number(from: self) != nil {
            return formatter.number(from: self)?.doubleValue ?? 0
        }
        
        return 0
    }
    
    var isInt: Bool {
        return Int(self) != nil
    }
    
    func convertToDictionary() -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}
