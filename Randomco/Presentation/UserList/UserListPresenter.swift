//
//  UserListPresenter.swift
//  Randomco
//
//  Created by Víctor Jimenez on 31/10/21.
//

import Combine

protocol UserListPresenter {
    var usersInteractor: UsersInteractor { get set }
    
    func setView(view: UserListViewController)
    func getUsers()
    func numberOfRows() -> Int
    func userForRow(row: Int) -> User
    func filterUsersByText(filter: String)
    func deleteUser(row: Int)
    func addFavouriteUser(row: Int)
    func navigateToDetail(row: Int)
    func navigateToFavourites()
}

class UserListPresenterDefault: UserListPresenter {
    var usersInteractor: UsersInteractor
    
    private weak var view: UserListViewController?
    private let memoryStorage: MemoryStorage
    private var users: [User] = []
    private var filteredUsers: [User] = []
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        usersInteractor = UsersInteractorDefault()
        memoryStorage = MemoryStorage.shared
    }
    
    func setView(view: UserListViewController) {
        self.view = view
        getUsers()
    }
    
    func getUsers() {
        usersInteractor.getUsers()
            .sink { [weak self] completion in
                switch completion {
                    case .finished:
                        return
                    case .failure(_):
                        self?.view?.showErrorAlert()
                        return
                    }
            } receiveValue: { [weak self] newUsers in
                self?.users = newUsers
                self?.filteredUsers = self?.users ?? []
                
                self?.view?.reloadTable()
            }.store(in: &subscriptions)
    }
    
    func filterUsersByText(filter: String) {
        if filter.isEmpty {
            removeFilters()
        } else {
            filteredUsers = filteredUsers.filter { $0.name.localizedCaseInsensitiveContains(filter) || $0.surname.localizedCaseInsensitiveContains(filter) || $0.email.localizedCaseInsensitiveContains(filter) }
            view?.reloadTable()
        }
    }
    
    private func removeFilters() {
        filteredUsers = users
        view?.reloadTable()
    }
    
    func numberOfRows() -> Int {
        return filteredUsers.count
    }
    
    func userForRow(row: Int) -> User {
        return filteredUsers[row]
    }
    
    func deleteUser(row: Int) {
        users.removeAll { $0 == filteredUsers[row] }
        filteredUsers.remove(at: row)
        saveUsers()
        
        view?.reloadTable()
    }
    
    func addFavouriteUser(row: Int) {
        guard let userRow = users.firstIndex(of: filteredUsers[row]) else {
            return
        }
        
        users[userRow].favourite = !users[userRow].favourite
        filteredUsers[row].favourite = !filteredUsers[row].favourite
        saveUsers()
    }
    
    private func saveUsers() {
        memoryStorage.save(data: users, key: Constants.usersKey)
    }
    
    func navigateToDetail(row: Int) {
        view?.navigateToDetail(user: filteredUsers[row])
    }
    
    func navigateToFavourites() {
        let favouriteUsers = users.filter { $0.favourite }
        view?.navigateToFavourites(users: favouriteUsers)
    }
}
