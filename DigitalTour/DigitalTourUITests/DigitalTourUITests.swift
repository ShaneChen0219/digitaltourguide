//
//  DigitalTourUITests.swift
//  DigitalTourUITests
//
//  Created by Shane Chen on 3/24/25.
//

import XCTest

final class DigitalTourUITests: XCTestCase {

    override func setUpWithError() throws {
            continueAfterFailure = false
        }
        
        func testLoginAndCitySelectionFlow() throws {
            let app = XCUIApplication()
            app.launch()
            
            // Check if a login button exists on the login screen.
            // (Adjust the identifier to match what you set in your LoginView.)
            let loginButton = app.buttons["Login with My Account"]
            XCTAssertTrue(loginButton.waitForExistence(timeout: 5), "Login button should appear")
            
            // Simulate tapping the login button.
            loginButton.tap()
            
            // Now check for an element on the city selection screen.
            // For example, the city name should appear as a button.
            let cityNameButton = app.buttons["New York"]
            XCTAssertTrue(cityNameButton.waitForExistence(timeout: 5), "City name button should appear after login")
            
            // Simulate tapping on a city to check if it navigates to the tour view.
            cityNameButton.tap()
            
            let mapView = app.otherElements["CitySelectionView"]
            XCTAssertTrue(mapView.waitForExistence(timeout: 5), "Map view should appear after selecting a city")
        }

    @MainActor
    func testLaunchPerformance() throws {
        if #available(iOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
