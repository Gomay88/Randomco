//
//  BaseRepository.swift
//  Randomco
//
//  Created by Víctor Jimenez on 30/10/21.
//

import Combine
import Foundation

protocol BaseRepository {
    func execute<T: Decodable>(request: HttpRequest) -> AnyPublisher<T, Error>
}

extension BaseRepository {
    func execute<T: Decodable>(request: HttpRequest) -> AnyPublisher<T, Error> {
        var urlComponents = URLComponents(string: request.stringURL)!
            
        if let data = request.parameter?.toJson(), request.encoded == .url {
            var queryItems = [URLQueryItem]()
            for (key,param) in data {
                queryItems.append(URLQueryItem(name: key, value: param as? String))
            }
            
            urlComponents.queryItems = queryItems
        }
        
        let url = urlComponents.url!
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        
        if request.encoded == .body {
            urlRequest.httpBody = request.parameter?.data()
        }
        
        for header in request.headers {
            urlRequest.setValue(header.value, forHTTPHeaderField: header.key)
        }
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
        .tryMap { output in
            guard let response = output.response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                throw RepositoryError.serverError
            }
            
            #if DEBUG
            if let url = response.url {
                print("⬅️ URL: \(url)")
            }

            print("⬅️ Statuscode: \(response.statusCode)")

            let body = String(bytes: output.data, encoding: .utf8) ?? ""
            print("⬅️ Body: \(body)")
            #endif
            
            return output.data
        }
        .receive(on: RunLoop.main)
        .decode(type: T.self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
    }
}

enum RepositoryError: Error {
    case mapError
    case nilDataError
    case serverError
    case urlError
    case encodedHeaderError
}

extension Encodable {
    func toJson() -> [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        guard let result = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else { return nil }
        return result
    }
    
    func data() -> Data? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        
        return data
    }
}
