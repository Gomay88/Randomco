//
//  UserDetailPresenterSpy.swift
//  RandomcoTests
//
//  Created by Víctor Jimenez on 31/10/21.
//

import Foundation
@testable import Randomco

class UserDetailPresenterSpy: UserDetailPresenter {
    var user: User?
    
    var setViewCalled = false
    
    func setView(view: UserDetailViewController) {
        setViewCalled = true
    }
}
