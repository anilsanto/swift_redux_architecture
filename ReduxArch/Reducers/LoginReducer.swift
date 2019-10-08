//
//  AuthenticatorReducer.swift
//  ReduxArch
//
//  Created by Anil Santo on 25/09/19.
//  Copyright © 2019 Anil Santo. All rights reserved.
//

import Foundation
import ReSwift

func loginViewModelReducer(action: Action, state: AppState?)->LoginViewModel{
    var state = state ?? AppState()
    switch action {
    case let action as SetUsernameAction:
        state.loginViewModel.userCredentials.username = action.username
        return state.loginViewModel
    case let action as SetPasswordAction:
        state.loginViewModel.userCredentials.password = action.password
        return state.loginViewModel
    case _ as AuthenticateStartAction:
        state.loginViewModel.loginState = .noAction
        return state.loginViewModel
    case let action as AuthenticateFailureAction:
        state.loginViewModel.setFailureState(response: action.errorResponse)
        return state.loginViewModel
    case let action as AuthenticateSuccessAction:
        state.loginViewModel.setSuccessState(response: action.response)
        return state.loginViewModel
    default:
        return state.loginViewModel
    }
}
