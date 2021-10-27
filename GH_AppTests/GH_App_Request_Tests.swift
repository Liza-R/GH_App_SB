//
//  GH_App_Request_Tests.swift
//  GH_AppTests
//
//  Created by Elizaveta Rogozhina on 27/10/2021.
//

import XCTest

@testable import GH_App

class GH_App_Request_Tests: XCTestCase {
    
    var sessionForTest: URLSession!

    override func setUp() {
        super.setUp()
        sessionForTest = URLSession(configuration: URLSessionConfiguration.default)
    }

    override func tearDown() {
        sessionForTest = nil
        super.tearDown()
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAllUsersRequest(){
        //given
        let url = URL(string: URLs().allUsersURL)
        let promise = expectation(description: "Status code: 200")
        validStatusCode200(url: url, promise: promise)
    }
    
    func testUserRequest(){
        //given
        let url = URL(string: "https://api.github.com/users/Liza-R")
        let promise = expectation(description: "Status code: 200")
        validStatusCode200(url: url, promise: promise)
    }
    
    func testUserReposRequest(){
        //given
        let url = URL(string: "https://api.github.com/users/Liza-R/repos")
        let promise = expectation(description: "Status code: 200")
        validStatusCode200(url: url, promise: promise)
    }
    
    func testSearchUserRequest(){
    //given
        let url = URL(string: "https://api.github.com/search/users?q=Liza-R")
        let promise = expectation(description: "Status code: 200")
        validStatusCode200(url: url, promise: promise)
    }
    
    func validStatusCode200(url: URL?, promise: XCTestExpectation) {
    //when
        let dataTask = sessionForTest.dataTask(with: url!){ data, response, error in
    //then
            if let error = error{
                XCTFail("Error: \(error.localizedDescription)")
                return
            }else if let statusCode = (response as? HTTPURLResponse)?.statusCode{
                  if statusCode == 200 {
                      promise.fulfill()
                  }else{
                      XCTFail("Status code: \(statusCode)")
                  }
            }
        }
        dataTask.resume()
        waitForExpectations(timeout: 3.0, handler: nil)
    }
}
