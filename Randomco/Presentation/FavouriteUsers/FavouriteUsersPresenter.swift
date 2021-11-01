//
//  FavouriteUsersPresenter.swift
//  Randomco
//
//  Created by Víctor Jimenez on 1/11/21.
//

import Foundation

protocol FavouriteUsersPresenter {
    var favouriteUsers: [User] { get set }
    
    func setView(view: FavouriteUsersViewController)
    func loadData()
    func numberOfRows() -> Int
    func userForRow(row: Int) -> User
}

class FavouriteUsersPresenterDefault: FavouriteUsersPresenter {
    private weak var view: FavouriteUsersViewController?
    var favouriteUsers: [User] = []
    
    init() {
    }
    
    func setView(view: FavouriteUsersViewController) {
        self.view = view
    }
    
    func loadData() {
        if favouriteUsers.isEmpty {
            view?.showErrorAlert()
        } else {
            view?.reloadTable()
        }
    }
    
    func numberOfRows() -> Int {
        return favouriteUsers.count
    }
    
    func userForRow(row: Int) -> User {
        return favouriteUsers[row]
    }
}
