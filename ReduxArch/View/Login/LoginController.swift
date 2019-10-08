//
//  LoginController.swift
//  ReduxArch
//
//  Created by Anil Santo on 25/09/19.
//  Copyright © 2019 Anil Santo. All rights reserved.
//

import UIKit
import ReSwift

class LoginController: MasterViewController {

    fileprivate let usernameField : UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Username"
        textfield.backgroundColor = .red
        return textfield
    }()
    
    fileprivate let passwordField : UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Password"
        textfield.backgroundColor = .red
        return textfield
    }()
    
    fileprivate let loginButton : BaseButton = {
        let btn = BaseButton()
        btn.backgroundColor = .orange
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        registerAction()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        appStore.subscribe(self)
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        appStore.unsubscribe(self)
        super.viewWillDisappear(animated)
    }
    
    fileprivate func setUpView(){
        view.backgroundColor = .white
        view.addSubview(usernameField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        
        usernameField.anchor(centerX: nil, centerY: view.centerYAnchor, padding: .init(x: 0, y: -40))
        usernameField.anchor(top: nil,
                             leading: view.leadingAnchor,
                             bottom: nil,
                             trailing: view.trailingAnchor ,
                             padding: .init(top: 0, left: 10, bottom: 01, right: 10),
                             size:.init(width: 0, height: 40))
        
        passwordField.anchor(top: usernameField.bottomAnchor,
                             leading: view.leadingAnchor,
                             bottom: nil,
                             trailing: view.trailingAnchor ,
                             padding: .init(top: 20, left: 10, bottom: 01, right: 10),
                             size:.init(width: 0, height: 40))
        
        loginButton.anchor(top: passwordField.bottomAnchor, leading: nil, bottom: nil, trailing: nil,padding: .init(top: 40, left: 0, bottom: 0, right: 0))
        loginButton.anchor(centerX: view.centerXAnchor, centerY: nil, size: .init(width: 300, height: 45))
        
    }
    
    fileprivate func registerAction(){
        usernameField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        loginButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
    }
    
    @objc func textFieldDidChange(textfield : UITextField){
        switch textfield {
        case usernameField:
            appStore.dispatch(SetUsernameAction(username: textfield.text ?? ""))
        case passwordField:
            appStore.dispatch(SetPasswordAction(password: textfield.text ?? ""))
        default:
            break
        }
    }
    
    @objc func loginAction(){
        appStore.dispatch(AuthenticateStartAction(request: appStore.state.loginViewModel.userCredentials))
        self.perform(#selector(stopLoader), with: nil, afterDelay: 5)
    }
    
    @objc func stopLoader(){
        appStore.dispatch(AuthenticateFailureAction(errorResponse: Response(responseBody: nil, responseCode: nil, errroBody: nil)))
    }
}

extension LoginController : StoreSubscriber{
    func newState(state: AppState) {
        usernameField.text = state.loginViewModel.userCredentials.username
        passwordField.text = state.loginViewModel.userCredentials.password
        switch state.loader {
        case .hide:
            hideLoader()
        case .show:
            self.view.endEditing(true)
            showLoader()
        }
        switch state.loginViewModel.loginState {
        case .invalid:
            showAlert(type: .warning, delegate: nil, inView: self, withTitle: "Warning", withSubtitle: "InValid", withDoneButtonTitle: "Ok", andCancelTitle: nil)
        default:
            break
        }
    }
}
