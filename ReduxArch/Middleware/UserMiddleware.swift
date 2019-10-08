//
//  SampleMiddleware.swift
//  ReduxArch
//
//  Created by Anil Santo on 25/09/19.
//  Copyright © 2019 Anil Santo. All rights reserved.
//

import ReSwift

func userAuthentication() -> AppMiddleware<AppState> {
    return { authenticateUser(action: $0, context: $1) }
}


private func authenticateUser(action: Action, context: MiddlewareContext<AppState>) -> Action? {
    guard let authenticateAction = action as? AuthenticateStartAction else{
        return action
    }
//    let
//    authenticateUser(requestBody: ) { (response) in
//        if let statusCode = response.responseCode,(200..<300).contains(statusCode){
//            context.dispatch(AuthenticateSuccessAction(response: response))
//        }
//        else{
//            context.dispatch(AuthenticateFailureAction(errorResponse: response))
//        }
//    }
    return action
}
