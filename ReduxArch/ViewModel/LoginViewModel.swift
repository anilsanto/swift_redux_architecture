//
//  LoginViewModel.swift
//  ReduxArch
//
//  Created by Anil Santo on 29/09/19.
//  Copyright © 2019 Anil Santo. All rights reserved.
//

import Foundation

enum LoginState : String{
    case invalid = "invalid_credentials"
    case forbiden = "forbiden"
    case timedout = "timedout"
    case noAction = "noAction"
}

struct LoginViewModel {
    var userCredentials : UserCredentials
    var loginState : LoginState
    
    init(){
        self.userCredentials = UserCredentials()
        self.loginState = .noAction
    }
    
    mutating func setSuccessState(response : Response<String,String>){
        self.loginState = .noAction
    }
    
    mutating func setFailureState(response : Response<String,String>){
        self.loginState = .invalid
    }
}
