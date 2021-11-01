//
//  UserDetailPresenterTests.swift
//  RandomcoTests
//
//  Created by Víctor Jimenez on 31/10/21.
//

import XCTest
@testable import Randomco

class UserDetailPresenterTests: XCTestCase {
    var presenter: UserDetailPresenter!
    var spy: UserDetailViewControllerSpy!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        
        presenter = UserDetailPresenterDefault()
        presenter.user = MockModels.MockUser
        spy = UserDetailViewControllerSpy(presenter: presenter)
        presenter.setView(view: spy)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        presenter = nil
        spy = nil
        try super.tearDownWithError()
    }
    
    func testConfigureView() {
        XCTAssertTrue(spy.configureViewCalled)
    }
}
