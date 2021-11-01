//
//  RequestBuilder.swift
//  Randomco
//
//  Created by Víctor Jimenez on 30/10/21.
//

import Foundation

enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
    case put = "PUT"
    case delete = "DELETE"
}

enum Encoded {
    case url
    case body
}

class RequestBuilder {
    
    fileprivate var host: String
    fileprivate var path: String
    
    fileprivate var headers: [String: String]
    fileprivate var parameter: Encodable?
    fileprivate var method: HTTPMethod
    fileprivate var encoded: Encoded
    
    fileprivate var urlTemplate: (String, String) -> (String)
    
    init(host: String = "", urlTemplate: @escaping (String, String) -> (String) = {"\($0)\($1)"}) {
        self.host = host
        self.path = ""
        
        self.headers = [:]
        self.method = .get
        self.encoded = .url
        
        self.urlTemplate = urlTemplate
    }
    
    func host(_ host: String) -> Self {
        self.host = host
        return self
    }
    
    func path(_ path: String) -> Self {
        self.path = path
        return self
    }
    
    func headers(_ headers: [String: String]) -> Self {
        self.headers = headers
        return self
    }
    
    func addOrUpdateHeader(key: String, value: String) -> Self {
        headers.updateValue(value, forKey: key)
        return self
    }
    
    func parameter(_ parameter: Encodable) -> Self {
        self.parameter = parameter
        return self
    }
    
    func method(_ method: HTTPMethod) -> Self {
        self.method = method
        return self
    }
    
    func get() -> Self {
        return method(.get)
    }
    
    func post() -> Self {
        return method(.post)
    }
    
    func put() -> Self {
        return method(.put)
    }
    
    func delete() -> Self {
        return method(.delete)
    }
    
    func encoded(_ encoded: Encoded) -> Self {
        self.encoded = encoded
        return self
    }
    
    func builtHttpRequest() -> HttpRequest {
        let url = urlTemplate(host, path)
        
        return HttpRequest(stringURL: url, method: method, headers: headers, parameter: parameter, encoded: encoded)
    }
}

extension RequestBuilder {
    static func randomco() -> RequestBuilder {
        return RequestBuilder(host: "http://api.randomuser.me") { (host, path) in
            return "\(host)/\(path)"
        }
    }
}
