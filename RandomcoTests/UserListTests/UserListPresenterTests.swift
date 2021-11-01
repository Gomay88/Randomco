//
//  UserListPresenterTests.swift
//  RandomcoTests
//
//  Created by Víctor Jimenez on 31/10/21.
//

import XCTest
@testable import Randomco

class UserListPresenterTests: XCTestCase {
    var presenter: UserListPresenter!
    var spy: UserListViewControllerSpy!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        
        presenter = UserListPresenterDefault()
        presenter.usersInteractor = MockUsersInteractorDefault(hasError: false)
        spy = UserListViewControllerSpy(presenter: presenter)
        presenter.setView(view: spy)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        presenter = nil
        spy = nil
        try super.tearDownWithError()
    }
    
    func testReloadTable() {
        presenter.filterUsersByText(filter: "V")
        XCTAssertTrue(spy.reloadTableCalled)
    }
    
    func testNavigateToDetail() {
        presenter.navigateToDetail(row: 0)
        XCTAssertTrue(spy.navigateToDetailCalled)
    }
    
    func testNavigateToFavourites() {
        presenter.navigateToFavourites()
        XCTAssertTrue(spy.navigateToFavouritesCalled)
    }
    
    func testShowError() {
        presenter = UserListPresenterDefault()
        presenter.usersInteractor = MockUsersInteractorDefault(hasError: true)
        spy = UserListViewControllerSpy(presenter: presenter)
        presenter.setView(view: spy)
        XCTAssertTrue(spy.showErrorAlertCalled)
    }
}
