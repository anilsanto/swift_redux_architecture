//
//  HelperClass.swift
//  HotelVoucher
//
//  Created by Anil Santo on 19/02/19.
//  Copyright © 2019 flydubai. All rights reserved.
//

import Foundation
import UIKit


func consoleLogger(string : String){
    if true{
        print(string)
    }
}

func findFontFamily(){
    for fontFamilyName in UIFont.familyNames{
        if fontFamilyName.contains("Hel"){
            for fontName in UIFont.fontNames(forFamilyName: fontFamilyName){
                print("Family: \(fontFamilyName)     Font: \(fontName)")
            }
        }
    }
}

let activityLoader : ActivityLoader = {
    let loader = ActivityLoader(frame: .zero)
    return loader
}()

func showLoader(){
    DispatchQueue.main.async {
        activityLoader.show(view: nil)
    }
    
}

func showLoader(forView view: UIView?){
    DispatchQueue.main.async {
        activityLoader.show(view: view)
    }
}

func hideLoader(){
    DispatchQueue.main.async {
        activityLoader.hide()
    }
}


let alertView = FZAlertView()
func showAlert(type : FZAlertType,delegate : FZAlertViewDelegate?, inView view: UIViewController, withTitle title: String?, withSubtitle subTitle: String, withDoneButtonTitle done: String?, andCancelTitle cancel: String?){
    alertView.delegate = nil
    DispatchQueue.main.async {
        alertView.removeFromSuperview()
    }
    if delegate != nil{
        alertView.delegate = delegate
    }
    DispatchQueue.main.async {
        alertView.showAlert(type: type, inView: view, withTitle: title, withSubtitle: subTitle, withDoneButtonTitle: done, andCancelTitle: cancel)
    }
}
