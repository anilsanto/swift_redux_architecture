//
//  ClosuerSelector.swift
//  reader
//
//  Created by Anil Santo on 19/10/18.
//  Copyright © 2018 Rostyslav_Zaiets. All rights reserved.
//

import Foundation

//Parameter is the type of parameter passed in the selector
public class ClosureSelector<Parameter> {
    
    public let selector : Selector
    private let closure : ( Parameter ) -> ()
    
    init(withClosure closure : @escaping ( Parameter ) -> ()){
        self.selector = #selector(ClosureSelector.target(param:))
        self.closure = closure
    }
    
    @objc func target( param : AnyObject) {
        closure(param as! Parameter)
    }
}
