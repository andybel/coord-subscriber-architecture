//
//  ListViewModelTests.swift
//  Arch List PLayTests
//
//  Created by Andy Bell on 25.02.19.
//  Copyright © 2019 snapp mobile. All rights reserved.
//

import XCTest

@testable import ArchitectureExample

class ListViewModelTests: XCTestCase {

    var sut: ListViewModel!

    override func setUp() {
        let mockedListService = ListLoadService(api: CoreApiMock())
        sut = ListViewModel(with: mockedListService)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testListViewModelReturnExpectedArticlesCount() {

        // GIVEN
        let exp = expectation(description: "ArticlesCountExp")

        // WHEN
        sut.subscribe { _ in
            exp.fulfill()
        }

        // THEN
        waitForExpectations(timeout: 3.0) { err in
            XCTAssertNil(err, "expectation error should be nil")

            XCTAssertEqual(self.sut.numberOfArticles(), 4, "numberOfArticles should equal 4 after subscribing")
        }
    }

    func testListViewModelReturnsExpectedTitle() {

        // GIVEN
        let exp = expectation(description: "ArticlesTitleExp")

        // WHEN
        sut.subscribe { _ in
            exp.fulfill()
        }

        // THEN
        let ip = IndexPath(item: 0, section: 0)
        waitForExpectations(timeout: 3.0) { err in
            XCTAssertNil(err, "expectation error should be nil")

            XCTAssertEqual(self.sut.articleTitle(at: ip), "mock article 1", "title of first article should equal 'mock article 1' after subscribing")
        }
    }

    func testItemSelectFiresExpectedCallback() {

        // GIVEN
        let exp = expectation(description: "ItemSelectExp")
        var selectedId: Int?
        sut.listSelectedArticleId = { id in
            selectedId = id
        }

        // WHEN
        sut.subscribe { _ in
            self.sut.selectedItem(at: IndexPath(item: 0, section: 0))
            exp.fulfill()
        }

        // THEN
        waitForExpectations(timeout: 3.0) { err in
            XCTAssertNil(err, "expectation error should be nil")

            XCTAssertNotNil(selectedId, "selected id should not be nil")
            XCTAssertEqual(selectedId, 1, "selectedId should equesl 1")
        }
    }

}
