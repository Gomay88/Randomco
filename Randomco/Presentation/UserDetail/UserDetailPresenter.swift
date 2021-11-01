//
//  UserDetailPresenter.swift
//  Randomco
//
//  Created by Víctor Jimenez on 31/10/21.
//

import Foundation

protocol UserDetailPresenter {
    var user: User? { get set }
    
    func setView(view: UserDetailViewController)
}

class UserDetailPresenterDefault: UserDetailPresenter {
    private weak var view: UserDetailViewController?
    
    var user: User?
    
    func setView(view: UserDetailViewController) {
        self.view = view
        configureView()
    }
    
    private func configureView() {
        guard let user = user else {
            return
        }
        
        view?.configureView(user: user)
    }
}
