//
//  UserDetailViewControllerTests.swift
//  RandomcoTests
//
//  Created by Víctor Jimenez on 31/10/21.
//

import XCTest
@testable import Randomco

class UserDetailViewControllerTests: XCTestCase {
    var viewController: UserDetailViewControllerDefault!
    var spy: UserDetailPresenterSpy!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        
        viewController = UserDetailViewControllerDefault.initFromStoryboard()
        spy = UserDetailPresenterSpy()
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
        XCTAssertNotNil(viewController.emailLabel)
        XCTAssertNotNil(viewController.registeredLabel)
        XCTAssertNotNil(viewController.locationLabel)
        XCTAssertNotNil(viewController.nameLabel)
        XCTAssertNotNil(viewController.genderLabel)
        XCTAssertNotNil(viewController.userImageView)
    }
    
    func testSetView() {
        viewController.viewDidLoad()
        XCTAssertTrue(spy.setViewCalled)
    }
}
