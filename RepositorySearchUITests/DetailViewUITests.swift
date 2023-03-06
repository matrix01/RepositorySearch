//
//  DetailViewUITests.swift
//  RepositorySearchUITests
//
//  Created by Matrix on 2023/03/06.
//

import XCTest

final class DetailViewUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_image_view_exists() {
        let app = XCUIApplication()
        app.launch()
        let timeout = 2.0
        
        let searchNavigationBar = app.navigationBars["Search"]
        let searchSearchField = searchNavigationBar.searchFields["Search"]
        searchSearchField.tap()
        searchSearchField.typeText("Hello")
        app.collectionViews.buttons.firstMatch.tap()
        
        let image = app.images["repoItemImageView"]
        XCTAssertTrue(image.waitForExistence(timeout: timeout))
        
        let urlText = app.staticTexts["repoUrlText"]
        XCTAssertTrue(urlText.waitForExistence(timeout: timeout))
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
