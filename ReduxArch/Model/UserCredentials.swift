//
//  UserCredentials.swift
//  ReduxArch
//
//  Created by Anil Santo on 25/09/19.
//  Copyright © 2019 Anil Santo. All rights reserved.
//

import Foundation

struct UserCredentials : Encodable {
    var username : String
    var password : String
    
    init(){
        username = ""
        password = ""
    }
}
