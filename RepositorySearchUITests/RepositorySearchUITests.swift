//
//  RepositorySearchUITests.swift
//  RepositorySearchUITests
//
//  Created by Matrix on 2023/03/04.
//

import XCTest

final class RepositorySearchUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_search_empty_view() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let timeout = 2.0
        let empty = app.staticTexts["Empty"]
        XCTAssertTrue(empty.waitForExistence(timeout: timeout))
        XCTAssertTrue(empty.exists)
    }
    
    func test_search_field_created() {
        let app = XCUIApplication()
        app.launch()
        
        let timeout = 2.0
        
        // Get the navigation bar and search bar from navigation bar
        let searchNavigationBar = app.navigationBars["Search"]
        let searchSearchField = searchNavigationBar.searchFields["Search"]
        XCTAssertTrue(searchSearchField.waitForExistence(timeout: timeout))
    }
    
    func test_search_field_input() {
        let app = XCUIApplication()
        app.launch()
        let timeout = 2.0
        
        // Get the navigation bar and search bar from navigation bar
        let searchNavigationBar = app.navigationBars["Search"]
        let searchSearchField = searchNavigationBar.searchFields["Search"]
        XCTAssertTrue(searchSearchField.waitForExistence(timeout: timeout))
        
        // Tap and start typing
        searchSearchField.tap()
        searchSearchField.typeText("Hello")
       
        let listItems = app.collectionViews.buttons
        XCTAssertTrue(listItems.firstMatch.waitForExistence(timeout: timeout))
        XCTAssertTrue(listItems.count > 0)
        XCTAssertEqual(searchSearchField.value as! String, "Hello")
    }
    
    func test_open_detail_view_on_select() {
        let app = XCUIApplication()
        app.launch()
        
        let searchNavigationBar = app.navigationBars["Search"]
        let searchSearchField = searchNavigationBar.searchFields["Search"]
        searchSearchField.tap()
        searchSearchField.typeText("Hello")
        
        app.collectionViews/*@START_MENU_TOKEN@*/.buttons["https://github.com/phonegap/phonegap-start"]/*[[".cells.buttons[\"https:\/\/github.com\/phonegap\/phonegap-start\"]",".buttons[\"https:\/\/github.com\/phonegap\/phonegap-start\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Detail"].buttons["Search"].tap()
        searchSearchField.tap()
        searchNavigationBar.buttons["Cancel"].tap()
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
