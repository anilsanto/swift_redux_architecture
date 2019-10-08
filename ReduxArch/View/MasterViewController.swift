//
//  ViewController.swift
//  ReduxArch
//
//  Created by Anil Santo on 25/09/19.
//  Copyright © 2019 Anil Santo. All rights reserved.
//

import UIKit
import ReSwift

class MasterViewController: UIViewController {
    
    var appStore : Store<AppState> {
        return appDelegate.appStore
    }
    
    var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

