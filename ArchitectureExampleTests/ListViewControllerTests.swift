//
//  ListViewControllerTests.swift
//  ArchitectureExampleTests
//
//  Created by Andy Bell on 27.02.19.
//  Copyright © 2019 snapp mobile. All rights reserved.
//

import XCTest
@testable import ArchitectureExample

class ListViewControllerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testListVCSetupsIbOutletsAsExpecfted() {

        // GIVEN
        let sut = ListViewController.instantiate()
        sut.viewModel = ListViewModel(with: ListLoadService())

        // WHEN
        sut.loadViewIfNeeded()

        // THEN
        XCTAssertNotNil(sut.tableView)
    }
}
