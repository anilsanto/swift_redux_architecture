//
//  UITextfield+extension.swift
//  SwiftEssentials
//
//  Created by Anil Santo on 27/08/18.
//  Copyright © 2018 Anil Santo. All rights reserved.
//

import Foundation
import UIKit

private var maxLengths = [UITextField: Int]()

public extension UITextField {
    
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
    
    @IBInspectable var maxLength: Int {
        get {
            guard let length = maxLengths[self] else {
                return Int.max
            }
            return length
        }
        set {
            maxLengths[self] = newValue
            addTarget(
                self,
                action: #selector(limitLength),
                for: UIControl.Event.editingChanged
            )
        }
    }
    
    @objc func limitLength(textField: UITextField) {
        guard let prospectiveText = textField.text, prospectiveText.count >= maxLength else {
            return
        }
        let newText = String(prospectiveText[...(maxLength-1)])
        self.text = newText
    }
    
    func setAccessoryView(withImage image: UIImage,isLeft : Bool = false,rect : CGRect = .init(x: 0, y: 0, width: 20, height: 20)){
        let imageView = UIImageView(frame: rect)
        imageView.image = image
        imageView.contentMode = .center
        if isLeft{
            self.leftView = imageView
            self.leftViewMode = .always
        }
        else{
            self.rightView = imageView
            self.rightViewMode = .always
        }
    }
}
