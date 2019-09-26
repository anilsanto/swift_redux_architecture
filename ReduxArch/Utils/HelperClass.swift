//
//  HelperClass.swift
//  HotelVoucher
//
//  Created by Anil Santo on 19/02/19.
//  Copyright © 2019 flydubai. All rights reserved.
//

import Foundation
import UIKit

let activityLoader : ActivityLoader = {
   let loader = ActivityLoader(frame: .zero)
    return loader
}()

let alertView = FZAlertView()

func consoleLogger(string : String){
    if consonleLog{
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

func parseFlightDetails(forPhysicalFlight flights : [PhysicalFlight])->[String]{
    var list : [String] = []
    flights.forEach { (flight) in
        var combinedFlight = ""
        if let sellingCarrier = flight.sellingCarrier,let sellingFlightNumber = flight.sellingFlightNumber{
            combinedFlight = sellingCarrier + "" + sellingFlightNumber + " "
        }
        if let origin = flight.origin,let destination = flight.destination{
            combinedFlight += origin + "-" + destination + " "
        }
        if let departureDate = flight.departureDate{
            let depDate = Date.formatDateWith(dateString: departureDate, fromFormat: "yyyy-MM-dd'T'HH:mm:ss", toFormat: "yyyy-MM-dd")
            combinedFlight += depDate
        }
        if !combinedFlight.isEmpty{
            list.append(combinedFlight)
        }
        else{
            list.append("Select".localized())
        }
    }
    return list
}
