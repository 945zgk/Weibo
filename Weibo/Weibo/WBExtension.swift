//
//  WBExtension.swift
//  Weibo
//
//  Created by 郑国凯 on 16/3/26.
//  Copyright © 2016年 郑国凯. All rights reserved.
//

import UIKit

// MARK: - UILabel

extension UILabel {
    
    class func labelWithFontSize(fontSize: CGFloat) -> UILabel {
        
        let lab = UILabel()
        
        lab.font = UIFont.systemFontOfSize(fontSize)
        lab.numberOfLines = 0
        lab.lineBreakMode = NSLineBreakMode.ByCharWrapping
        
        return lab
        
    }
    
}

// MARK: - UIView

extension UIView {
    
    @IBInspectable var shadowRadius: CGFloat {
        set {
            self.layer.shadowRadius = newValue
        }
        get {
            return self.shadowRadius
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        set {
            self.layer.shadowOpacity = newValue
        }
        get {
            return self.shadowOpacity
        }
    }
    
    @IBInspectable var shadowColor: UIColor? {
        set {
            self.layer.shadowColor = newValue?.CGColor
        }
        get {
            return self.shadowColor
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        set {
            self.layer.shadowOffset = newValue
        }
        get {
            return self.shadowOffset
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            self.layer.cornerRadius = newValue
        }
        get {
            return self.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            self.layer.borderColor = newValue?.CGColor
        }
        get {
            return self.borderColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            self.layer.borderWidth = newValue
        }
        get {
            return self.borderWidth
        }
    }
    
}

// MARK: - NSUserDefaults

var Defaults = NSUserDefaults.standardUserDefaults()

extension NSUserDefaults {
    
    subscript(key: DefaultsKey<String?>) -> String? {
        get {
            return stringForKey(key.key)
        }
        set {
            setObject(newValue, forKey: key.key)
        }
    }
    
    subscript(key: DefaultsKey<String>) -> String {
        get {
            return stringForKey(key.key) ?? ""
        }
        set {
            setObject(newValue, forKey: key.key)
        }
    }
    
    subscript(key: DefaultsKey<Double?>) -> Double? {
        get {
            return doubleForKey(key.key)
        }
        set {
            setObject(newValue, forKey: key.key)
        }
    }
    
    subscript(key: DefaultsKey<Double>) -> Double {
        get {
            return doubleForKey(key.key) ?? 0.0
        }
        set {
            setObject(newValue, forKey: key.key)
        }
    }
    
    subscript(key: DefaultsKey<Float?>) -> Float? {
        get {
            return floatForKey(key.key)
        }
        set {
            setObject(newValue, forKey: key.key)
        }
    }
    
    subscript(key: DefaultsKey<Float>) -> Float {
        get {
            return floatForKey(key.key) ?? 0.0
        }
        set {
            setObject(newValue, forKey: key.key)
        }
    }
    
    subscript(key: DefaultsKey<Int?>) -> Int? {
        get {
            return integerForKey(key.key)
        }
        set {
            setObject(newValue, forKey: key.key)
        }
    }
    
    subscript(key: DefaultsKey<Int>) -> Int {
        get {
            return integerForKey(key.key) ?? 0
        }
        set {
            setObject(newValue, forKey: key.key)
        }
    }
    
    subscript(key: DefaultsKey<Bool?>) -> Bool? {
        get {
            return boolForKey(key.key)
        }
        set {
            setObject(newValue, forKey: key.key)
        }
    }
    
    subscript(key: DefaultsKey<Bool>) -> Bool {
        get {
            return boolForKey(key.key) ?? false
        }
        set {
            setObject(newValue, forKey: key.key)
        }
    }
    
    subscript(key: DefaultsKey<NSData?>) -> NSData? {
        get {
            return dataForKey(key.key)
        }
        set {
            setObject(newValue, forKey: key.key)
        }
    }
    
    subscript(key: DefaultsKey<NSData>) -> NSData {
        get {
            return dataForKey(key.key) ?? NSData()
        }
        set {
            setObject(newValue, forKey: key.key)
        }
    }
    
    subscript(key: DefaultsKey<[AnyObject]?>) -> [AnyObject]? {
        get {
            return arrayForKey(key.key)
        }
        set {
            setObject(newValue, forKey: key.key)
        }
    }
    
    subscript(key: DefaultsKey<[AnyObject]>) -> [AnyObject] {
        get {
            return arrayForKey(key.key) ?? [AnyObject]()
        }
        set {
            setObject(newValue, forKey: key.key)
        }
    }
    
    subscript(key: DefaultsKey<[String : AnyObject]?>) -> [String : AnyObject]? {
        get {
            return dictionaryForKey(key.key)
        }
        set {
            setObject(newValue, forKey: key.key)
        }
    }
    
    subscript(key: DefaultsKey<[String : AnyObject]>) -> [String : AnyObject] {
        get {
            return dictionaryForKey(key.key) ?? [String : AnyObject]()
        }
        set {
            setObject(newValue, forKey: key.key)
        }
    }
    
    subscript(key: DefaultsKey<[String]?>) -> [String]? {
        get {
            return stringArrayForKey(key.key)
        }
        set {
            setObject(newValue, forKey: key.key)
        }
    }
    
    subscript(key: DefaultsKey<[String]>) -> [String] {
        get {
            return stringArrayForKey(key.key) ?? [String]()
        }
        set {
            setObject(newValue, forKey: key.key)
        }
    }
    
}

extension UITableView {
    
}

// MARK: - UIBarButtonItem

extension UIBarButtonItem {
    
    class func createBarButtonItem(imageName: String, target: AnyObject?, action: Selector) -> UIBarButtonItem {
        
        let btn = UIButton()
        
        btn.setImage(UIImage(named: imageName), forState: .Normal)
        btn.setImage(UIImage(named: "\(imageName)_highlighted"), forState: .Highlighted)
        btn.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        btn.sizeToFit()
        
        return UIBarButtonItem(customView: btn)
        
    }
    
}
