//
//  Business_ClubTests.swift
//  Business ClubTests
//
//  Created by Jerald Abille on 2/13/19.
//  Copyright © 2019 Jerald Abille. All rights reserved.
//

import XCTest
@testable import Business_Club

class Business_ClubTests: XCTestCase {
  
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
  
  func testSampleData() {
    let testExpectation = XCTestExpectation(description: "Test Sample Data")
    guard let url = URL(string: "https://next.json-generator.com/api/json/get/Vk-LhK44U") else { return }
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
      if let data = data {
        let result = try? JSONDecoder().decode([Company].self, from: data)
        print(result as Any)
        XCTAssert(result?.count == 20)
        if let company = result?.first {
          XCTAssert(company.members.count > 0)
        }
        testExpectation.fulfill()
      }
    }
    task.resume()
    wait(for: [ testExpectation ], timeout: 30.0)
  }
}
