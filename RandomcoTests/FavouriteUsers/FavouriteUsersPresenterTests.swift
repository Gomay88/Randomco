//
//  FavouriteUsersPresenterTests.swift
//  RandomcoTests
//
//  Created by Víctor Jimenez on 1/11/21.
//

import XCTest
@testable import Randomco

class FavouriteUsersPresenterTests: XCTestCase {
    var presenter: FavouriteUsersPresenter!
    var spy: FavouriteUsersViewControllerSpy!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        
        presenter = FavouriteUsersPresenterDefault()
        presenter.favouriteUsers = [MockModels.MockUser]
        spy = FavouriteUsersViewControllerSpy(presenter: presenter)
        presenter.setView(view: spy)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        presenter = nil
        spy = nil
        try super.tearDownWithError()
    }
    
    func testReloadTable() {
        presenter.loadData()
        XCTAssertTrue(spy.reloadTableCalled)
    }
    
    func testShowError() {
        presenter = FavouriteUsersPresenterDefault()
        presenter.favouriteUsers = []
        spy = FavouriteUsersViewControllerSpy(presenter: presenter)
        presenter.setView(view: spy)
        presenter.loadData()
        XCTAssertTrue(spy.showErrorAlertCalled)
    }
}
