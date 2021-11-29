//
//  UsersRepository.swift
//  Randomco
//
//  Created by Víctor Jimenez on 30/10/21.
//

import Foundation
import Combine

protocol UsersRepository {
    func getUsers() -> AnyPublisher<UsersResponse, Error>
}

class UsersRepositoryDefault: BaseRepository, UsersRepository {
    func getUsers() -> AnyPublisher<UsersResponse, Error> {
        let request = RequestBuilder.randomco()
        .get()
        .parameter(["results": "40"])
        .encoded(.url)
        .builtHttpRequest()
        
        return execute(request: request)
    }
}
