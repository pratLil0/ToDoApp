//
//  ErrorModel.swift
//  ToDo App
//
//  Created by Pratyush Srivastava on 28/01/22.
//

import Foundation

struct ErrorModel : Decodable {
    var errorType: String?
    var errorCode: Int?
    var message: String?
    
    
    init(errorType: String?,errorCode:Int?, message: String?){
        self.errorType = errorType
        self.errorCode = errorCode
        self.message = message
    }
}
