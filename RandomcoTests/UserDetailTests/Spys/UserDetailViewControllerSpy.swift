//
//  UserDetailViewControllerSpy.swift
//  RandomcoTests
//
//  Created by Víctor Jimenez on 31/10/21.
//

import Foundation
@testable import Randomco

class UserDetailViewControllerSpy: UserDetailViewController {
    var presenter: UserDetailPresenter
    
    var configureViewCalled = false
    
    init(presenter: UserDetailPresenter) {
        self.presenter = presenter
    }
    
    func configureView(user: User) {
        configureViewCalled = true
    }
}
