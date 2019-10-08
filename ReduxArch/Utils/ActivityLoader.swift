//
//  ActivityLoader.swift
//  HotelVoucher
//
//  Created by Anil Santo on 25/02/19.
//  Copyright © 2019 flydubai. All rights reserved.
//

import UIKit

class ActivityLoader: UIView {
    
    private let backgroundView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    private let loaderIcon : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Loader")
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }
    
    fileprivate func setUpView(){
        backgroundColor = .init(r: 0, g: 0, b: 0, a: 0.50)
        addSubview(backgroundView)
        backgroundView.anchor(centerX: centerXAnchor, centerY: centerYAnchor, size: .init(width: 60, height: 60))
        backgroundView.addSubview(loaderIcon)
        loaderIcon.fillSuperview()
    }
    
    fileprivate func repeateAnimation(){
        let animation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation")
        animation.fromValue = 0
        animation.toValue = 2 * Double.pi
        animation.repeatCount = Float.infinity
        animation.duration = 1.5;
        
        loaderIcon.layer.add(animation, forKey: "rotation")
    }
    
    func show(view : UIView?){
        self.removeFromSuperview()
        let window : UIWindow = UIApplication.shared.keyWindow!
        if view != nil{
            self.frame = (view?.bounds)!
            view?.addSubview(self)
        }
        else{
            window.addSubview(self)
        }
        self.fillSuperview()
        repeateAnimation()
    }
    
    func hide(){
        loaderIcon.layer.removeAllAnimations()
        self.removeFromSuperview()
    }
    
}
