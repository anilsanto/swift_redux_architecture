//
//  LoaderReducer.swift
//  ReduxArch
//
//  Created by Anil Santo on 25/09/19.
//  Copyright © 2019 Anil Santo. All rights reserved.
//

import ReSwift


func loaderReducer(action: Action, state: AppState?)->Loader{
    let state = state ?? AppState()
    switch action {
    case _ as LoaderShowAction:
        return Loader.show
    case _ as LoaderHideAction:
        return Loader.hide
    case let action as AuthenticateStartAction:
        return action.loader
    case let action as AuthenticateFailureAction:
        return action.loader
    case let action as AuthenticateSuccessAction:
        return action.loader
    default:
        return state.loader
    }
}
