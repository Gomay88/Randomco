//
//  FavouriteUsersViewControllerTests.swift
//  RandomcoTests
//
//  Created by Víctor Jimenez on 1/11/21.
//

import XCTest
@testable import Randomco

class FavouriteUsersViewControllerTests: XCTestCase {
    var viewController: FavouriteUsersViewControllerDefault!
    var spy: FavouriteUsersPresenterSpy!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        
        viewController = FavouriteUsersViewControllerDefault.initFromStoryboard()
        spy = FavouriteUsersPresenterSpy()
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
        XCTAssertNotNil(viewController.tableView)
    }
    
    func testSetView() {
        viewController.viewDidLoad()
        XCTAssertTrue(spy.setViewCalled)
    }
    
    func testLoadData() {
        viewController.viewWillAppear(true)
        XCTAssertTrue(spy.loadDataCalled)
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
}
