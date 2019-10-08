//
//  State.swift
//  ReduxArch
//
//  Created by Anil Santo on 25/09/19.
//  Copyright © 2019 Anil Santo. All rights reserved.
//

import ReSwift

struct AppState : StateType{
    var loader : Loader
    var loginViewModel : LoginViewModel
    
    init() {
        self.loader = .hide
        self.loginViewModel = LoginViewModel()
    }
}

enum Loader {
    case show
    case hide
}
