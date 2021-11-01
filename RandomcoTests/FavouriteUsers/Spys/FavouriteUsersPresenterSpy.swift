//
//  FavouriteUsersPresenterSpy.swift
//  RandomcoTests
//
//  Created by Víctor Jimenez on 1/11/21.
//

import Foundation
@testable import Randomco

class FavouriteUsersPresenterSpy: FavouriteUsersPresenter {
    
    var setViewCalled = false
    var loadDataCalled = false
    var numberOfRowsCalled = false
    var userForRowCalled = false
    
    var favouriteUsers: [User] = []
    
    func setView(view: FavouriteUsersViewController) {
        setViewCalled = true
    }
    
    func loadData() {
        loadDataCalled = true
    }
    
    func numberOfRows() -> Int {
        numberOfRowsCalled = true
        return 1
    }
    
    func userForRow(row: Int) -> User {
        userForRowCalled = true
        return MockModels.MockUser
    }
}
