//
//  WeatherProjectTests.swift
//  WeatherProjectTests
//
//  Created by Phoenix McKnight on 10/10/19.
//  Copyright © 2019 Phoenix McKnight. All rights reserved.
//

import XCTest
@testable import WeatherProject

class WeatherProjectTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testDateFunction() {
    

        
    }
    
   private func weatherMODEL() -> Data? {
        let bundle = Bundle(for: type(of: self))
        guard let pathToData = bundle.path(forResource: "WeatherTest", ofType: ".json")  else {
            XCTFail("couldn't find Json")
            return nil
        }
        let url = URL(fileURLWithPath: pathToData)
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch let error {
            fatalError("couldn't find data \(error)")
        }
    }

    func testLoadWeather () {
        let data = weatherMODEL() ?? Data()
        let weather = WeatherModel.getWeatherDataTest(from: data) ?? []
        XCTAssertTrue(weather.count > 0, "No weather was loaded")
}
}
