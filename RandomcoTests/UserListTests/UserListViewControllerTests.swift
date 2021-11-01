//
//  UserListViewControllerTests.swift
//  RandomcoTests
//
//  Created by Víctor Jimenez on 31/10/21.
//

import XCTest
@testable import Randomco

class UserListViewControllerTests: XCTestCase {
    var viewController: UserListViewControllerDefault!
    var spy: UserListPresenterSpy!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        
        viewController = UserListViewControllerDefault.initFromStoryboard()
        spy = UserListPresenterSpy(usersInteractor: MockUsersInteractorDefault(hasError: false))
        viewController.presenter = spy
        viewController.loadView()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewController = nil
        spy = nil
        try super.tearDownWithError()
    }
    
    func testView() {
        XCTAssertNotNil(viewController.searchBar)
        XCTAssertNotNil(viewController.tableView)
        XCTAssertNotNil(viewController.moreUsersButton)
        XCTAssertNotNil(viewController.showFavouritesButton)
    }
    
    func testSetView() {
        viewController.viewDidLoad()
        XCTAssertTrue(spy.setViewCalled)
    }
    
    func testGetUsers() {
        viewController.didTapMoreUsers(viewController.moreUsersButton ?? UIButton())
        XCTAssertTrue(spy.getUsersCalled)
    }
    
    func testFilter() {
        viewController.searchBarSearchButtonClicked(viewController.searchBar)
        XCTAssertTrue(spy.filterUsersByTextCalled)
    }
    
    func testNumberOfRows() {
        let rows = viewController.tableView(viewController.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(rows, 1)
        XCTAssertTrue(spy.numberOfRowsCalled)
    }
    
    func testUserForRow() {
        let cell = viewController.tableView(viewController.tableView, cellForRowAt: IndexPath(row: 1, section: 0))
        XCTAssertTrue(cell is UserListCell)
        XCTAssertTrue(spy.userForRowCalled)
    }
    
    func testDeleteUser() {
        viewController.didDeleteUser(tag: 0)
        XCTAssertTrue(spy.deleteUserCalled)
    }
    
    func testAddFavouriteUser() {
        viewController.didAddFavorite(tag: 0)
        XCTAssertTrue(spy.addFavouriteUserCalled)
    }
    
    func testNavigateToDetail() {
        viewController.didTapCellImage(tag: 0)
        XCTAssertTrue(spy.navigateToDetailCalled)
    }
    
    func testShowFavourites() {
        viewController.didTapShowFavouritesButton(viewController.showFavouritesButton ?? UIButton())
        XCTAssertTrue(spy.navigateToFavouritesCalled)
    }
}
