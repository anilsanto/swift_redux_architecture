//
//  BaseButton.swift
//  SwiftEssentials
//
//  Created by Anil Santo on 27/08/18.
//  Copyright © 2018 Anil Santo. All rights reserved.
//

import UIKit

public class BaseButton: UIButton {
    
    @IBInspectable var borderColor : UIColor = UIColor.white{
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth : CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius : CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var bgColor : UIColor = UIColor.white {
        didSet {
            self.backgroundColor = bgColor
        }
    }
    
    @IBInspectable var titleFont : UIFont = UIFont.systemFont(ofSize: 12) {
        didSet {
            self.titleLabel?.font = titleFont
        }
    }
    
    @IBInspectable var titleTextColor :  UIColor = UIColor.white {
        didSet {
            self.setTitleColor(titleTextColor, for: .normal)
        }
    }
}
