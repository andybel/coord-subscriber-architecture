//
//  ArticleViewControllerTests.swift
//  ArchitectureExampleTests
//
//  Created by Andy Bell on 27.02.19.
//  Copyright © 2019 snapp mobile. All rights reserved.
//

import XCTest
@testable import ArchitectureExample

class ArticleViewControllerTests: XCTestCase {

    var sut: ArticleViewController!

    override func setUp() {
        sut = ArticleViewController.instantiate()
        sut.viewModel = FakeArticleVM()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testListVCSetsIBOutletsAsExpected() {

        // GIVEN
        //setup

        // WHEN
        sut.loadViewIfNeeded()

        // THEN
        XCTAssertNotNil(sut.titleLabel)

    }

    func testListVCSetsInitialUIAsExpected() {

        // GIVEN
        // setup

        // WHEN
        sut.loadViewIfNeeded()
        sut.viewDidLoad()

        // THEN
        XCTAssertTrue(sut.titleLabel.text?.isEmpty ?? false)
        XCTAssertTrue(sut.mainTextView.text?.isEmpty ?? false)
        XCTAssertTrue(sut.spinner.isAnimating)
    }

    func testListVCSetsUIAfterSubscribingAsExpected() {

        // GIVEN
        let exp = expectation(description: "SetUIExpectation")

        // WHEN
        sut.loadViewIfNeeded()
        sut.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            exp.fulfill()
        }

        // THEN
        waitForExpectations(timeout: 3.0) { err in
            XCTAssertNil(err)

            XCTAssertEqual(self.sut.titleLabel.text, "Mock Article")
            XCTAssertEqual(self.sut.mainTextView.text, "Mock Article Body")
            XCTAssertNotNil(self.sut.commentsBarBtn)
            XCTAssertFalse(self.sut.spinner.isAnimating)
        }
    }
}

class FakeArticleVM: ArticleViewModelProtocol {

    func subscribe(with updateCallback: ViewModelCallback) {
        updateCallback?(nil)
    }

    func articleTitle() -> String {
        return "Mock Article"
    }

    func articleBody() -> String {
        return "Mock Article Body"
    }

    func commentsCount() -> Int {
        return 10
    }



}
