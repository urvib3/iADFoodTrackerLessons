//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by Urvi Bhuwania on 12/17/20.
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    //MARK: Meal Class Tests
    
    // Confirm the Meal initializer returns a Meal object when given the correct parameteres
    func testMealWithInitializationSucceeds() {
        
        // Zero rating
        let zeroRatingMeal = Meal.init(name: "Zero", photo: nil, rating: 0)
        XCTAssertNotNil(zeroRatingMeal)
        
        //Highest positive rating
        let fiveRatingMeal = Meal.init(name: "five rating", photo: nil, rating: 5)
        XCTAssertNotNil(fiveRatingMeal)
        
    }
    
    // Confirm the meal initializer fails when passed invalid parameters
    func testMealInitializationFails() {
        
        // negative rating
        let negativeRatingMeal = Meal.init(name: "Negative", photo: nil, rating: -1)
        XCTAssertNil(negativeRatingMeal)
        
        // no name
        let emptyNameMeal = Meal.init(name: "", photo: nil, rating: 3)
        XCTAssertNil(emptyNameMeal)
        
        // rating that exceeds maximum
        let largeRatingMeal = Meal.init(name: "six rating", photo: nil, rating: 6)
        XCTAssertNil(largeRatingMeal)
    }

}
