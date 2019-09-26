//
//  String+extension.swift
//  SwiftEssentials
//
//  Created by Anil Santo on 27/08/18.
//  Copyright © 2018 Anil Santo. All rights reserved.
//

import Foundation
import UIKit

public extension String {
    
    var firstCharacter : String {
        if self.isEmpty {
            return self
        }
        return String(self[self.startIndex])
    }
    
    var numberString : String{
        var formattedStr = self
        
        while(formattedStr.firstCharacter == "0"){
            formattedStr.remove(at: formattedStr.startIndex)
        }
        return formattedStr
    }
    
    var capitalizeFirst: String {
        if self.isEmpty {
            return self
        }
        return String(self[self.startIndex]).capitalized + String(self.dropFirst())
    }
    
    var isValidEmail : Bool {
        if self.isEmpty {
            return false
        }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]{2,}\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    var isAlphanumeric: Bool {
        if self.isEmpty {
            return true
        }
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    
    var isOnlyAphabets : Bool {
        if self.isEmpty{
            return true
        }
        let charRegEx = "[a-zA-Z\\s]+"
        let charTest = NSPredicate(format:"SELF MATCHES %@", charRegEx)
        return charTest.evaluate(with: self)
    }
    
    var isOnlyAphabetsAndNoSpace : Bool {
        if self.isEmpty{
            return true
        }
        let charRegEx = "[a-zA-Z]+"
        let charTest = NSPredicate(format:"SELF MATCHES %@", charRegEx)
        return charTest.evaluate(with: self)
    }
    
    var isOnlyNumbers : Bool {
        if self.isEmpty{
            return true
        }
        let numberRegEx = "[0-9%+-]+"
        let numberTest = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        return numberTest.evaluate(with: self)
    }
    
    var isValidPassword : Bool {
        if self.isEmpty{
            return false
        }
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: self)
    }
    
    var stripSpecialChars: String {
        return  self.replacingOccurrences(of: "[^0-9a-zA-Z]", with: "", options: .regularExpression, range: nil)
    }
    
    var trimWhiteSpace : String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func validate(forPattern pattern : String)->Bool{
        if self.isEmpty {
            return false
        }
        let charTest = NSPredicate(format:"SELF MATCHES %@", pattern)
        return !self.isEmpty && charTest.evaluate(with: self)
    }
    
    //: ### Base64 encoding a string
    func base64Encoded() -> String? {
        if let data = self.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }
    
    //: ### Base64 decoding a string
    func base64Decoded() -> String? {
        if let data = Data(base64Encoded: self) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
    func heightForString(withFont font: UIFont, width: CGFloat, insets: UIEdgeInsets) -> CGFloat {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width + insets.left + insets.right, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = self
        label.sizeToFit()
        return label.frame.height + insets.top + insets.bottom
    }
    
    func htmlAttributedString() -> NSAttributedString? {
        guard let data = self.data(using: String.Encoding.utf16, allowLossyConversion: false) else { return nil }
        guard let html = try? NSMutableAttributedString(
            data: data,
            options: [ NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil) else { return nil }
        return html
    }
    
    func jsonObject() -> Dictionary<String, Any?>? {
        if let data = self.data(using: .utf8) {
            return data.jsonObject()
        }
        return nil
    }
    
    func toData()->Data{
        return self.data(using: .utf8)!
    }
    
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: "**\(self)**", comment: "")
    }
}

extension String {
    subscript(value: NSRange) -> Substring {
        return self[value.lowerBound..<value.upperBound]
    }
}

extension String {
    subscript(value: CountableClosedRange<Int>) -> Substring {
        get {
            return self[index(at: value.lowerBound)...index(at: value.upperBound)]
        }
    }
    
    subscript(value: CountableRange<Int>) -> Substring {
        get {
            return self[index(at: value.lowerBound)..<index(at: value.upperBound)]
        }
    }
    
    subscript(value: PartialRangeUpTo<Int>) -> Substring {
        get {
            return self[..<index(at: value.upperBound)]
        }
    }
    
    subscript(value: PartialRangeThrough<Int>) -> Substring {
        get {
            return self[...index(at: value.upperBound)]
        }
    }
    
    subscript(value: PartialRangeFrom<Int>) -> Substring {
        get {
            return self[index(at: value.lowerBound)...]
        }
    }
    
    func index(at offset: Int) -> String.Index {
        return index(startIndex, offsetBy: offset)
    }
}
