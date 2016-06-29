//
//  MengDayTests.swift
//  MengDayTests
//
//  Created by Weijie Wang on 2016-06-17.
//  Copyright © 2016 Weijie Wang. All rights reserved.
//

import XCTest
@testable import MengDay

class MengDayTests: XCTestCase {
    
    var viewController: MengDayListViewController!
    
    override func setUp() {
        super.setUp()
        
        viewController = MengDayListViewController()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testViewController_HasTableView() {
        XCTAssertNotNil(viewController.tableView)
    }
}
