//
//  Response.swift
//  ReduxArch
//
//  Created by Anil Santo on 25/09/19.
//  Copyright © 2019 Anil Santo. All rights reserved.
//

import Foundation

struct Response <T: Decodable,E: Decodable>{
    var responseBody : T?
    var responseCode : Int?
    var errroBody : E?
}

struct Request <R: Encodable>{
    var requestBody : R
    var method : String
    var header : Dictionary<String,String>
}
