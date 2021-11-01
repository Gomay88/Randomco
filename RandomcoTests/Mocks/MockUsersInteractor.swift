//
//  MockUserListViewController.swift
//  RandomcoTests
//
//  Created by Víctor Jimenez on 31/10/21.
//

import Foundation
import Combine
@testable import Randomco

class MockUsersInteractorDefault: UsersInteractor {
    
    let hasError: Bool
    
    init(hasError: Bool) {
        self.hasError = hasError
    }
    
    func getUsers() -> AnyPublisher<[User], Error> {
        if hasError {
            return Fail<[User], Error>(error: RepositoryError.serverError).eraseToAnyPublisher()
        } else {
            return Just<[User]>([MockModels.MockUser])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        }
    }
}
