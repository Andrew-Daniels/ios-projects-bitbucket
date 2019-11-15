//
//  PickupGamesTests.swift
//  PickupGamesTests
//
//  Created by Andrew Daniels on 9/23/19.
//  Copyright © 2019 Andrew Daniels. All rights reserved.
//

import XCTest
@testable import PickupGames

class PickupGamesTests: XCTestCase {
    
    private var entityFactory: EntityFactorySingleton!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        entityFactory = EntityFactorySingleton.instance
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func test_pathBuilder_replacementStrings() {
        let testString = "ThisIs/A/Test/{0}/{1}"
        let newString = testString.pathBuilder(replacementStrings: "Boop", "Teehee")
        XCTAssertEqual(newString, "ThisIs/A/Test/Boop/Teehee")
    }
    
    func test_pathBuilder_replacementStrings2() {
        let testString = "ThisIs/A/Test/{0}/{1}"
        let newString = testString.pathBuilder(replacementStrings: "Boop", "Teehee", "What?Why")
        XCTAssertEqual(newString, "ThisIs/A/Test/Boop/Teehee/What?Why")
    }
    
    func test_pathBuilder() {
        let testString = "ThisIs/A/Test/{0}/{1}"
        let newString = testString.pathBuilder()
        XCTAssertEqual(newString, "ThisIs/A/Test")
    }

}
