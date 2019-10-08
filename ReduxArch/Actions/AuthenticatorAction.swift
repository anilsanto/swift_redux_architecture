//
//  AuthenticatorAction.swift
//  ReduxArch
//
//  Created by Anil Santo on 25/09/19.
//  Copyright © 2019 Anil Santo. All rights reserved.
//

import ReSwift

struct AuthenticateStartAction : Action{
    let loader : Loader = .show
    var request : UserCredentials
}

struct AuthenticateFailureAction : Action{
    let loader : Loader = .hide
    var errorResponse : Response<String,String>
}

struct AuthenticateSuccessAction : Action{
    let loader : Loader = .hide
    var response : Response<String,String>
}

struct SetUsernameAction : Action{
    var username : String
}

struct SetPasswordAction : Action{
    var password : String
}


