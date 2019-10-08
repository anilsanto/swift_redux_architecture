//
//  FZAlertView.swift
//  HotelVoucher
//
//  Created by Anil Santo on 19/02/19.
//  Copyright © 2019 flydubai. All rights reserved.
//

import UIKit

enum FZAlertType {
    case warning
    case caution
    case success
    case note
}

extension FZAlertType {
    var value : UIColor{
        get {
            switch self {
            case .warning:
                return .red
            case .caution:
                return .yellow
            case .success:
                return .green
            case .note:
                return .blue
            }
        }
    }
    
    var text : String{
        get {
            switch self {
            case .warning:
                return "Warning".localized()
            case .caution:
                return "Caution".localized()
            case .success:
                return "Success".localized()
            case .note:
                return "Note".localized()
            }
        }
    }
}

@objc protocol FZAlertViewDelegate {
    @objc optional func FZAlertViewDismissed(alertView: FZAlertView)
    @objc optional func FZAlertViewWillAppear(alertView: FZAlertView)
    @objc optional func FZAlertDoneButtonClicked(alertView: FZAlertView)
    @objc optional func FZAlertCancelButtonClicked(alertView: FZAlertView)
}

class FZAlertView: UIView {

    fileprivate let contianerView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 3
        view.clipsToBounds = true
        return view
    }()
    
    fileprivate let messageTitle : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    fileprivate let messageTextView : UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 12)
        textView.textColor = .black
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isSelectable = false
        return textView
    }()
    
    fileprivate let buttonView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    fileprivate var messageHeight : NSLayoutConstraint?
    
    fileprivate let maxHeight = 300.0
    fileprivate let minHeight = 180.0
    
    var delegate : FZAlertViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }
    
    func setUpView(){
        backgroundColor = .init(r: 0, g: 0, b: 0, a: 0.50)
        addSubview(contianerView)
        
        contianerView.anchor(centerX: nil, centerY: centerYAnchor)
        contianerView.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 15, bottom: 0, right: 15))
        contianerView.heightAnchor.constraint(greaterThanOrEqualToConstant: CGFloat(minHeight)).isActive = true
        
        
        contianerView.addSubview(messageTitle)
        contianerView.addSubview(messageTextView)
        contianerView.addSubview(buttonView)
        
        messageTitle.anchor(top: contianerView.topAnchor, leading: contianerView.leadingAnchor, bottom: nil, trailing: contianerView.trailingAnchor,padding: .init(top: 15, left: 5, bottom: 0, right: 5))
        messageTextView.anchor(top: messageTitle.bottomAnchor, leading: messageTitle.leadingAnchor, bottom: nil, trailing: messageTitle.trailingAnchor,padding: .init(top: 3, left: 0, bottom: 0, right: 0))
        buttonView.anchor(top: messageTextView.bottomAnchor, leading: contianerView.leadingAnchor, bottom: contianerView.bottomAnchor, trailing: contianerView.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: 0),size: .init(width: 0, height: 50))
    }

    func initilizeAlertType(alertType : FZAlertType){
        switch alertType {
        case .success:
            messageTitle.textColor = FZAlertType.success.value
        case .caution:
            messageTitle.textColor = FZAlertType.caution.value
        case .warning:
            messageTitle.textColor = FZAlertType.warning.value
        case .note:
            messageTitle.textColor = FZAlertType.note.value
        }
    }
    
    public func showAlert(type : FZAlertType, inView view: UIViewController, withTitle title: String?, withSubtitle subTitle: String, withDoneButtonTitle done: String?, andCancelTitle cancel: String?) {
        
        initilizeAlertType(alertType: type)
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        messageTextView.textAlignment = .center
        messageTitle.text = title
        messageTextView.text = subTitle
        let contentSize = messageTextView.sizeThatFits(messageTextView.bounds.size)
        let height = Int(contentSize.height)
        if height > Int(maxHeight){
            messageTextView.heightAnchor.constraint(equalToConstant: CGFloat(maxHeight)).isActive = true
        }
        else if height < 60{
            messageTextView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        }
        else{
            messageTextView.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
        }
        let window : UIWindow = UIApplication.shared.keyWindow!
        window.addSubview(self)
        self.fillSuperview()
        initilizeAlertButtons(withDoneButtonTitle: done, andCancelTitle: cancel)
        showAnimate()
    }
    
    func initilizeAlertButtons(withDoneButtonTitle done: String?, andCancelTitle cancel: String?){
        var btnArray : [UIButton] = [UIButton]()
        var doneBtn : UIButton?
        if done != nil {
            doneBtn = UIButton(type: .custom)
            doneBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            doneBtn?.translatesAutoresizingMaskIntoConstraints = false
            doneBtn?.backgroundColor = .orange
            doneBtn?.layer.cornerRadius = 2
            doneBtn?.clipsToBounds = true
            doneBtn?.setTitle(done, for: .normal)
            doneBtn?.setTitleColor(UIColor.white, for: .normal)
            doneBtn?.addTarget(self, action: #selector(self.doneAction), for: .touchUpInside)
        }
        var cancelBtn : UIButton?
        if cancel != nil{
            cancelBtn = UIButton(type: .custom)
            cancelBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            cancelBtn?.translatesAutoresizingMaskIntoConstraints = false
            cancelBtn?.backgroundColor = .orange
            cancelBtn?.layer.cornerRadius = 2
            cancelBtn?.clipsToBounds = true
            cancelBtn?.setTitle(cancel, for: .normal)
            cancelBtn?.setTitleColor(UIColor.white, for: .normal)
            cancelBtn?.addTarget(self, action: #selector(self.cancelAction), for: .touchUpInside)
        }
        if doneBtn != nil{
            btnArray.append(doneBtn!)
        }
        if cancelBtn != nil{
            btnArray.append(cancelBtn!)
        }
        addButtons(btnArray: btnArray)
    }
    
    func addButtons(btnArray : [UIButton]){
        if btnArray.count > 1{
            let containerView = UIView()
            containerView.backgroundColor = UIColor.clear
            containerView.translatesAutoresizingMaskIntoConstraints = false
            buttonView.addSubview(containerView)
            containerView.anchor(top: buttonView.topAnchor, leading: nil, bottom: buttonView.bottomAnchor, trailing: nil,padding: .init(top: 10, left: 0, bottom: 10, right: 0),size: .init(width: 230, height: 30))
            containerView.centerXAnchor.constraint(equalTo: buttonView.centerXAnchor).isActive = true
            let done = btnArray.first
            let cancel = btnArray.last
            containerView.addSubview(done!)
            containerView.addSubview(cancel!)
            
            done?.anchor(top: containerView.topAnchor, leading: cancel?.trailingAnchor, bottom: containerView.bottomAnchor, trailing: containerView.trailingAnchor,padding: .init(top: 0, left: 30, bottom: 0, right: 0),size: .init(width: 100, height: 30))
            cancel?.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: containerView.bottomAnchor, trailing: nil,size: .init(width: 100, height: 30))
        }
        else{
            let done = btnArray.first
            buttonView.addSubview(done!)
            done?.anchor(top: buttonView.topAnchor, leading: nil, bottom: buttonView.bottomAnchor, trailing: nil,padding: .init(top: 10, left: 0, bottom: 10, right: 0),size: .init(width: 100, height: 30))
            done?.anchor(centerX: buttonView.centerXAnchor, centerY: nil)
        }
    }
    
    @objc func cancelAction(sender : UIButton){
        removeAnimate()
    }
    
    @objc func doneAction(sender : UIButton){
        UIView.animate(withDuration: 0.25, animations: {
            self.contianerView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.contianerView.alpha = 0.0
        }, completion: {(finished : Bool) in
            if(finished){
                self.delegate?.FZAlertDoneButtonClicked?(alertView: self)
                self.removeFromSuperview()
            }
        })
    }
    
    func showAnimate(){
        self.contianerView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.contianerView.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.contianerView.alpha = 1.0
            self.contianerView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.delegate?.FZAlertViewWillAppear?(alertView: self)
        })
    }
    
    func removeAnimate(){
        UIView.animate(withDuration: 0.25, animations: {
            self.contianerView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.contianerView.alpha = 0.0
        }, completion: {(finished : Bool) in
            if(finished){
                self.delegate?.FZAlertViewDismissed?(alertView: self)
                self.removeFromSuperview()
            }
        })
    }
    
}
