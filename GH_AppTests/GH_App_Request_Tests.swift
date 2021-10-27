//
//  GH_App_Request_Tests.swift
//  GH_AppTests
//
//  Created by Elizaveta Rogozhina on 27/10/2021.
//

import XCTest

@testable import GH_App

class GH_App_Request_Tests: XCTestCase {
    
    var createSessionForTest: URLSession!
    let promiseStatus = "Completion handler invoked"

    override func setUp() {
        super.setUp()
        createSessionForTest = URLSession(configuration: URLSessionConfiguration.default)
    }

    override func tearDown() {
        createSessionForTest = nil
        super.tearDown()
    }

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func testAllUsersRequest(){
    //given
        let url = URL(string: URLs().allUsersURL)
        let promise = expectation(description: promiseStatus)
        validStatusCode200(url: url, promise: promise)
    }
    
    func testUserRequest(){
    //given
        let url = URL(string: "https://api.github.com/users/Liza-R")
        let promise = expectation(description: promiseStatus)
        validStatusCode200(url: url, promise: promise)
    }
    
    func testUserReposRequest(){
    //given
        let url = URL(string: "https://api.github.com/users/Liza-R/repos")
        let promise = expectation(description: promiseStatus)
        validStatusCode200(url: url, promise: promise)
    }
    
    func testSearchUserRequest(){
    //given
        let url = URL(string: "https://api.github.com/search/users?q=Liza-R")
        let promise = expectation(description: promiseStatus)
        validStatusCode200(url: url, promise: promise)
    }
    
    func validStatusCode200(url: URL?, promise: XCTestExpectation) {
    //given
        var statusCode: Int?,
            responseError: Error?
    //when
        let dataTask = createSessionForTest.dataTask(with: url!){ data, response, error in
    //then
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        dataTask.resume()
        waitForExpectations(timeout: 3.0, handler: nil)
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
}
