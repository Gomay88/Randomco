//
//  GetUsersInteractor.swift
//  Randomco
//
//  Created by Víctor Jimenez on 30/10/21.
//

import Foundation
import Combine

protocol UsersInteractor {
    func getUsers() -> AnyPublisher<[User], Error>
}

class UsersInteractorDefault: UsersInteractor {
    private let usersRepository: UsersRepository
    private let memoryStorage: MemoryStorage
    
    init() {
        usersRepository = UsersRepositoryDefault()
        memoryStorage = MemoryStorage.shared
    }
    
    func getUsers() -> AnyPublisher<[User], Error> {
        return usersRepository.getUsers()
            .flatMap { response in
                Just<[User]>(self.checkDuplicateUsers(responseResults: response.results))
                    .eraseToAnyPublisher()
            }.eraseToAnyPublisher()
    }
    
    private func checkDuplicateUsers(responseResults: [UsersResponse.Results]) -> [User] {
        let responseUsers = responseResults.compactMap {
            User(name: $0.name.first,
                 surname: $0.name.last,
                 email: $0.email,
                 smallPicture: $0.picture.thumbnail,
                 largePicture: $0.picture.large,
                 phone: $0.phone,
                 gender: $0.gender,
                 location: $0.location,
                 registeredDate: $0.registered.date,
                 favourite: false)
        }
        
        let savedUsers = memoryStorage.retrive(key: Constants.usersKey) as? [User] ?? []
        let combineUsers = Array(Set(savedUsers + responseUsers))
        memoryStorage.save(data: combineUsers, key: Constants.usersKey)

        return combineUsers.sorted { $0.name < $1.name }
    }
}
