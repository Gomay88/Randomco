//
//  FavouriteUsersViewControllerSpy.swift
//  RandomcoTests
//
//  Created by Víctor Jimenez on 1/11/21.
//

import Foundation
@testable import Randomco

class FavouriteUsersViewControllerSpy: FavouriteUsersViewController {
    
    var reloadTableCalled = false
    var showErrorAlertCalled = false
    
    var presenter: FavouriteUsersPresenter
    
    init(presenter: FavouriteUsersPresenter) {
        self.presenter = presenter
    }
    
    func reloadTable() {
        reloadTableCalled = true
    }
    
    func showErrorAlert() {
        showErrorAlertCalled = true
    }
}
