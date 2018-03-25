//
//  LoginHelper.swift
//  GroundSpeed
//
//  Created by Don Miller on 6/20/17.
//  Copyright © 2017 GroundSpeed, LLC. All rights reserved.
//

import UIKit
import Foundation

class LogicHelper {
    
    static func saveUsernameToCloud(_ username: String) {
        let defaults = UserDefaults(suiteName: Constants.CloudCredentialsSuiteName)
        defaults!.set(username, forKey: "username")
        defaults?.synchronize()
    }
    
    static func fetchUsernameFromCloud() -> String {
        let defaults = UserDefaults(suiteName: Constants.CloudCredentialsSuiteName)
        defaults?.synchronize()
        let username = defaults!.string(forKey: "username") ?? ""
        
        return username
    }
    
    static func savePasswordToCloud(_ password: String) {
        let defaults = UserDefaults(suiteName: Constants.CloudCredentialsSuiteName)
        defaults!.set(password, forKey: "password")
        defaults?.synchronize()
    }
    
    static func fetchPasswordFromCloud() -> String {
        let defaults = UserDefaults(suiteName: Constants.CloudCredentialsSuiteName)
        defaults?.synchronize()
        let password = defaults!.string(forKey: "password") ?? ""
        
        return password
    }
    
    static func saveTokenToCloud(_ authToken: String) {
        let defaults = UserDefaults(suiteName: Constants.CloudCredentialsSuiteName)
        defaults!.set(authToken, forKey: "authToken")
        defaults?.synchronize()
    }
    
    static func fetchTokenFromCloud() -> String {
        let defaults = UserDefaults(suiteName: Constants.CloudCredentialsSuiteName)
        defaults?.synchronize()
        let authToken = defaults!.string(forKey: "authToken") ?? ""
        
        return authToken
    }
    
    static func saveDeviceToCloud(_ authToken: String) {
        let defaults = UserDefaults(suiteName: Constants.CloudCredentialsSuiteName)
        defaults!.set(authToken, forKey: "DeviceToken")
        defaults?.synchronize()
    }
    
    static func fetchDeviceFromCloud() -> String {
        let defaults = UserDefaults(suiteName: Constants.CloudCredentialsSuiteName)
        defaults?.synchronize()
        let deviceToken = defaults!.string(forKey: "DeviceToken") ?? ""
        
        return deviceToken
    }

    static func nullToNil(_ value : AnyObject?) -> AnyObject? {
        if value is NSNull {
            return "" as AnyObject?
        } else {
            return value
        }
    }
    
    static func formatStringToCurrency(_ numberToFormat: String) -> NSDecimalNumber {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.currency
        
        let limit = formatter.number(from: numberToFormat) as? NSDecimalNumber
        
        return limit!
    }
    
}
