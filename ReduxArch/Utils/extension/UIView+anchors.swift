//
//  UIView+anchors.swift
//  Created by Anil Santo
//

import UIKit

extension UIView {
    /**
     - Parameters:
        - padding: UIEdgeInsets to sepcify the view padding
     */
    func fillSuperview(padding: UIEdgeInsets) {
        anchor(top: superview?.topAnchor, leading: superview?.leadingAnchor, bottom: superview?.bottomAnchor, trailing: superview?.trailingAnchor, padding: padding)
    }
    /**
         function gives zero padding to the superview
     */
    func fillSuperview() {
        fillSuperview(padding: .zero)
    }
    /**
     - Parameters:
        - view: The view to which the size has to be anchored
     */
    func anchorSize(to view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    /**
     - Parameters:
         - top: Top Y Axis Anchor
         - leading: Left X Axis Anchor
         - bottom:
         - trailing:
         - padding:
         - size:
     */
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    func anchor(centerX : NSLayoutXAxisAnchor?,centerY : NSLayoutYAxisAnchor?, padding: CGPoint = .zero, size: CGSize = .zero){
        translatesAutoresizingMaskIntoConstraints = false
        if let centerX = centerX{
            centerXAnchor.constraint(equalTo: centerX, constant: padding.x).isActive = true
        }
        
        if let centerY = centerY{
            centerYAnchor.constraint(equalTo: centerY, constant: padding.y).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
        
    }
    
    func anchor(width : NSLayoutDimension?,height : NSLayoutDimension?, multiplier : CGFloat = 1.0,constant : CGFloat = 0.0){
        translatesAutoresizingMaskIntoConstraints = false
        if let width = width{
            widthAnchor.constraint(equalTo: width, multiplier: multiplier, constant: constant).isActive = true
        }
        
        if let height = height{
            heightAnchor.constraint(equalTo: height, multiplier: multiplier, constant: constant).isActive = true
        }
    }
    
}

