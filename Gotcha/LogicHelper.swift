//
//  LoginHelper.swift
//  PagePlus
//
//  Created by Don Miller on 6/20/17.
//  Copyright © 2017 GroundSpeed, LLC. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON

class LogicHelper {
    
    static func saveUsernameToCloud(_ username: String) {
        let defaults = UserDefaults(suiteName: "group.com.PagePlus.MyAccount.credentials")
        defaults!.set(username, forKey: "username")
        defaults?.synchronize()
    }
    
    static func fetchUsernameFromCloud() -> String {
        let defaults = UserDefaults(suiteName: "group.com.PagePlus.MyAccount.credentials")
        defaults?.synchronize()
        let username = defaults!.string(forKey: "username") ?? ""
        
        return username
    }
    
    static func savePasswordToCloud(_ password: String) {
        let defaults = UserDefaults(suiteName: "group.com.PagePlus.MyAccount.credentials")
        defaults!.set(password, forKey: "password")
        defaults?.synchronize()
    }
    
    static func fetchPasswordFromCloud() -> String {
        let defaults = UserDefaults(suiteName: "group.com.PagePlus.MyAccount.credentials")
        defaults?.synchronize()
        let password = defaults!.string(forKey: "password") ?? ""
        
        return password
    }
    
    static func saveTokenToCloud(_ authToken: String) {
        let defaults = UserDefaults(suiteName: "group.com.PagePlus.MyAccount.credentials")
        defaults!.set(authToken, forKey: "authToken")
        defaults?.synchronize()
    }
    
    static func fetchTokenFromCloud() -> String {
        let defaults = UserDefaults(suiteName: "group.com.PagePlus.MyAccount.credentials")
        defaults?.synchronize()
        let authToken = defaults!.string(forKey: "authToken") ?? ""
        
        return authToken
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

extension UIApplication {
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}

extension UIColor {
    static let ppRedColor : UIColor = UIColor.init(hex: "#ef3e42")
    static let ppBlueColor : UIColor = UIColor.init(hex: "#c9e9ee")
    static let ppYellowColor : UIColor = UIColor.init(hex: "#fbb034")
    static let ppGreenRedColor : UIColor = UIColor.init(hex: "#b4d88b")
    static let ppBlackColor : UIColor = UIColor.init(hex: "#231f20")
    static let ppDarkGrayColor : UIColor = UIColor.init(hex: "#424143")
    static let ppGrayColor : UIColor = UIColor.init(hex: "#807f83")
    static let ppWhiteColor : UIColor = UIColor.init(hex: "#ffffff")
    
    convenience init(colorWithHexValue value: Int, alpha:CGFloat = 1.0){
        self.init(
            red: CGFloat((value & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((value & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(value & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
    
    convenience init(hex: String, alpha:CGFloat = 1.0){
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

extension UITextField {
    
    func underlined(color: CGColor) {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = color
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    
    func transparentUnderlined(color: CGColor) {
        let border = CALayer()
        let width = CGFloat(0.5)
        border.borderWidth = width
        border.borderColor = color
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height)
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}

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

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIView {
    
    func roundRedCorner() {
        self.layer.borderColor = UIColor.ppRedColor.cgColor
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
        self.layer.borderColor = UIColor.ppRedColor.cgColor
        self.layer.borderWidth = 1
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    var toCurrencyFromDouble:String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        return formatter.string(from: self as NSNumber)!
    }
}

extension Int {
    
    var toDate:Date {
        return Date(timeIntervalSince1970: (TimeInterval(self / 1000)))
    }
    
    var stringValue:String {
        return "\(self)"
    }
}

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

extension UIImageView {
    
    func changeTintColor(imageName:String, tintColor:UIColor) {
        let nameImage = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        self.image = nameImage
        self.tintColor = tintColor
    }
}

extension JSON {
    
    public var date: Date? {
        get {
            switch self.type {
            case .string:
                return Formatter.jsonDateFormatter.date(from: self.object as! String)
            default:
                return nil
            }
        }
    }
    
    public var dateTime: Date? {
        get {
            switch self.type {
            case .string:
                return Formatter.jsonDateTimeFormatter.date(from: self.object as! String)
            default:
                return nil
            }
        }
    }
}

extension UIViewController {
    func presentAlert(_ message: String) {
        let alert = UIAlertController(
            title: "Alert",
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in }))
        self.present(alert, animated: true, completion: nil)
    }
}

extension Date {
    
    func minDate() -> Date {
        let gregorian: NSCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let currentDate: Date = Date()
        let components: NSDateComponents = NSDateComponents()
        components.year = -150
        
        return gregorian.date(byAdding: components as DateComponents, to: currentDate, options: NSCalendar.Options(rawValue: 0))!
    }
    
    func maxDate() -> Date {
        let gregorian: NSCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let currentDate: Date = Date()
        let components: NSDateComponents = NSDateComponents()
        components.year = 150
        
        return gregorian.date(byAdding: components as DateComponents, to: currentDate, options: NSCalendar.Options(rawValue: 0))!
    }
    
    func toString(format:String) -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = format
        let result = formatter.string(from: self)
        
        return result
    }
    
    func toLongString() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d"
        
        return dateFormatter.string(from: self).capitalized
    }
    
    var toUTC:String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let result = formatter.string(from: self)
        
        return result
    }
}

class Formatter {
    
    private static var internalJsonDateFormatter: DateFormatter?
    private static var internalJsonDateTimeFormatter: DateFormatter?
    
    static var jsonDateFormatter: DateFormatter {
        if (internalJsonDateFormatter == nil) {
            internalJsonDateFormatter = DateFormatter()
            internalJsonDateFormatter!.dateFormat = "yyyy-MM-dd"
        }
        return internalJsonDateFormatter!
    }
    
    static var jsonDateTimeFormatter: DateFormatter {
        if (internalJsonDateTimeFormatter == nil) {
            internalJsonDateTimeFormatter = DateFormatter()
            internalJsonDateTimeFormatter!.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            
        }
        return internalJsonDateTimeFormatter!
    }
    
}
