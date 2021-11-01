//
//  UserListViewControllerSpy.swift
//  RandomcoTests
//
//  Created by Víctor Jimenez on 31/10/21.
//

import Foundation
@testable import Randomco

class UserListViewControllerSpy: UserListViewController {
    var presenter: UserListPresenter
    
    var reloadTableCalled = false
    var navigateToDetailCalled = false
    var showErrorAlertCalled = false
    var navigateToFavouritesCalled = false
    
    init(presenter: UserListPresenter) {
        self.presenter = presenter
    }
    
    func reloadTable() {
        reloadTableCalled = true
    }
    
    func navigateToDetail(user: User) {
        navigateToDetailCalled = true
    }
    
    func showErrorAlert() {
        showErrorAlertCalled = true
    }
    
    func navigateToFavourites(users: [User]) {
        navigateToFavouritesCalled = true
    }
}
