//
//  DigitalTourTests.swift
//  DigitalTourTests
//
//  Created by Shane Chen on 3/24/25.
//

import XCTest
@testable import DigitalTour

final class DigitalTourTests: XCTestCase {

    func testLoadCities() throws {
        // Call your JSON parsing function
        let cities = loadCities()
        // Verify that the returned array is not empty.
        XCTAssertFalse(cities.isEmpty, "Expected cities array to not be empty")
        
        // Optionally, you can test the first city's properties.
        if let firstCity = cities.first {
            XCTAssertFalse(firstCity.cityName.isEmpty, "City name should not be empty")
            XCTAssertFalse(firstCity.spots.isEmpty, "City should have at least one spot")
        }
    }
    
    // Example async test using the new XCTest async/await API
    func testExample() async throws {
        // Write your test here and use APIs like `XCTExpectFailure` if needed.
        // For instance, simulate an async network fetch and verify the result:
        let expectation = expectation(description: "Async fetch")
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 2)
    }
}
