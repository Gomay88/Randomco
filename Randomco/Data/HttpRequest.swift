//
//  HttpRequest.swift
//  Randomco
//
//  Created by Víctor Jimenez on 30/10/21.
//

import Foundation

class HttpRequest {
    var stringURL: String
    var method: HTTPMethod
    var parameter: Encodable?
    var headers: [String:String]
    var encoded: Encoded
    
    init(stringURL: String, method: HTTPMethod, headers: [String:String], parameter: Encodable?, encoded: Encoded) {
        self.stringURL = stringURL
        self.method = method
        self.headers = headers
        self.parameter = parameter
        self.encoded = encoded
    }
}
