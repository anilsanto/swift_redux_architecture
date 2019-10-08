//
//  AppReducer.swift
//  ReduxArch
//
//  Created by Anil Santo on 25/09/19.
//  Copyright © 2019 Anil Santo. All rights reserved.
//

import ReSwift

func appReducer(action: Action, state: AppState?) -> AppState {
    var state = state ?? AppState()
    
    state.loader = loaderReducer(action: action, state: state)
    state.loginViewModel = loginViewModelReducer(action: action, state: state)
    
    return state
}

