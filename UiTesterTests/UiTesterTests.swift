//
//  UiTesterUITests.swift
//  UiTesterUITests
//
//  Created by Tzuu Yao Lee on 21/9/20.
//  Copyright © 2020 Tzuu Yao Lee. All rights reserved.
//

import XCTest

class UiTesterUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        continueAfterFailure = false
        app.launch()
    }
    
    override func tearDown() {
        app = nil
        super.tearDown()
    }
    
    func testOnboarding_WhenSwiped_NextVCLoads() {
        app.launch()
        
        XCTAssertTrue(app.staticTexts["Page 1"].exists)
        
        app.swipeLeft()
        
        XCTAssertTrue(app.staticTexts["Page 2"].exists)
        
    }
    func testOnboarding_WhenAlertButtonTapped_PresentAlert() {
        app.launch()
        
        app.swipeLeft()
        app.swipeLeft()
        
        app.buttons["Alert"].tap()
        XCTAssertTrue(app.alerts["Alert"].exists)
    }
    
    func testOnboarding_WhenFinished_OnboardVCDismisses() {
        app.launch()
        
        XCTAssertTrue(app.isDisplayingOnboarding)
        
        app.swipeLeft()
        app.swipeLeft()
        
        app.buttons["Done"].tap()
        
        XCTAssertFalse(app.isDisplayingOnboarding)
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}


extension XCUIApplication {
    var isDisplayingOnboarding: Bool {
        return otherElements["onboardingView"].exists
    }
}
