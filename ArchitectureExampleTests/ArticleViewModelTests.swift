//
//  ArticleViewModelTests.swift
//  ArchitectureExampleTests
//
//  Created by Andy Bell on 27.02.19.
//  Copyright © 2019 snapp mobile. All rights reserved.
//

import XCTest

@testable import ArchitectureExample

class ArticleViewModelTests: XCTestCase {

    var sut: ArticleViewModel!

    override func setUp() {
        let mockId = 1
        let mockArticlesService = ArticleService(api: CoreApiMock())
        sut = ArticleViewModel(with: mockArticlesService, articleId: mockId)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testArticleCommentsReturnsExpectedCount() {

        // GIVEN
        let exp = expectation(description: "CommentsCountExp")

        // WHEN
        sut.subscribe { _ in
            exp.fulfill()
        }

        // THEN
        waitForExpectations(timeout: 3.0) { err in
            XCTAssertNil(err, "expectation error should be nil")

            XCTAssertEqual(self.sut.commentsCount(), 3, "commentsCount should equal 3 after subscribing")
        }
    }

    func testArticleValuesReturnExpectedResults() {

        // GIVEN
        let exp = expectation(description: "TitleExp")

        // WHEN
        sut.subscribe { _ in
            exp.fulfill()
        }

        // THEN
        waitForExpectations(timeout: 3.0) { err in
            XCTAssertNil(err, "expectation error should be nil")

            let mockBody = "quia molestiae reprehenderit quasi aspernatur\naut expedita occaecati aliquam eveniet laudantium\nomnis quibusdam delectus saepe quia accusamus maiores nam est\ncum et ducimus et vero voluptates excepturi deleniti ratione"

            XCTAssertEqual(self.sut.articleTitle(), "Mocked Article", "title should equal 'Mocked Article' after subscribing")
            XCTAssertEqual(self.sut.articleBody(), mockBody, "body should equal '\(mockBody)' after subscribing")
        }
    }

}
