//
//  SportsAppTests.swift
//  SportsAppTests
//
//  Created by Salma on 10/05/2024.
//

import XCTest
@testable import SportsApp

final class SportsAppTests: XCTestCase {

    var networkHandler:NetworkHandler?
    var mockNetwork: MockNetworkHandler?
    override func setUpWithError() throws {
        
        networkHandler = NetworkHandler.instance
        
        mockNetwork = MockNetworkHandler(shouldReturnError: false)
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        
        networkHandler = nil
        mockNetwork = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    
    
    func testFetchDataFromNetwork() {
        
        let myExpectation = expectation(description: "wait api result")
        networkHandler?.loadData(url: "football/?met=Leagues", onCompletion: { (leagues : League?, error) in
            
            
            if let error = error {
                print(error)
                myExpectation.fulfill()
                XCTFail()
            }
            else {
                
                XCTAssertNotNil(leagues)
                                
                myExpectation.fulfill()
            }
            
            
        })
        waitForExpectations(timeout: 10)
    }
    
    
    func testFetchDataFromNetwork_failCase() {
        
        let myExpectation = expectation(description: "wait api result")
        networkHandler?.loadData(url: "football/?met=League", onCompletion: { (leagues : League?, error) in
            
            
            if let error = error {
                print(error)
                myExpectation.fulfill()
                XCTFail()
            }
            else {
                
                XCTAssertNotNil(leagues)
                                
                myExpectation.fulfill()
            }
            
            
        })
        waitForExpectations(timeout: 10)
    }
    
    func testMockClass() {
        
        mockNetwork?.loadData(onComplition: { (leagues:League? , error) in
            
            if let error = error {
                
                XCTAssertNil(leagues)
                XCTFail()
            }
            
            if let leagues = leagues {
                XCTAssertEqual(leagues.result?.count, 1)
            }
            
            
        })
    }
    
    
}

