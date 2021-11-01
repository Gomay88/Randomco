//
//  UserListPresenterSpy.swift
//  RandomcoTests
//
//  Created by Víctor Jimenez on 31/10/21.
//

import Foundation
@testable import Randomco

class UserListPresenterSpy: UserListPresenter {
    var usersInteractor: UsersInteractor
    
    init(usersInteractor: UsersInteractor) {
        self.usersInteractor = usersInteractor
    }
    
    var setViewCalled = false
    var getUsersCalled = false
    var filterUsersByTextCalled = false
    var numberOfRowsCalled = false
    var userForRowCalled = false
    var deleteUserCalled = false
    var addFavouriteUserCalled = false
    var navigateToDetailCalled = false
    var navigateToFavouritesCalled = false
    
    func setView(view: UserListViewController) {
        setViewCalled = true
    }
    
    func getUsers() {
        getUsersCalled = true
    }
    
    func filterUsersByText(filter: String) {
        filterUsersByTextCalled = true
    }
    
    func numberOfRows() -> Int {
        numberOfRowsCalled = true
        return 1
    }
    
    func userForRow(row: Int) -> User {
        userForRowCalled = true
        return MockModels.MockUser
    }
    
    func deleteUser(row: Int) {
        deleteUserCalled = true
    }
    
    func addFavouriteUser(row: Int) {
        addFavouriteUserCalled = true
    }
    
    func navigateToDetail(row: Int) {
        navigateToDetailCalled = true
    }
    
    func navigateToFavourites() {
        navigateToFavouritesCalled = true
    }
}
