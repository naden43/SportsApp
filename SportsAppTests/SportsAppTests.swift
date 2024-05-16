//
//  SportsAppTests.swift
//  SportsAppTests
//
//  Created by Salma on 10/05/2024.
//

import XCTest
@testable import SportsApp

final class SportsAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    
    func testFetchDataFromJson() {
        let networkHandler = NetworkHandler.instance
          
          let expectation = XCTestExpectation(description: "Waiting for API response")

          networkHandler.loadData(url: "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=abc02ea64120a2a2b030bed665f226a1d66f109fa9f94eae9a6c66c8ca00d785") { (result: Event?, error: Error?) in
              if let error = error {
                        XCTFail("Error: \(error.localizedDescription)")
                    } else {
                      
                        XCTAssertNotNil(result)
                        XCTAssertNil(error)
                    }
                    expectation.fulfill()
           
          }
      }
}

