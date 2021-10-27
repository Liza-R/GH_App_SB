//
//  GH_AppUITests.swift
//  GH_AppUITests
//
//  Created by Elizaveta Rogozhina on 21/09/2021.
//

import XCTest

private var app: XCUIApplication!

class GH_AppUITests: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testTableAllUsersSwipes(){
        let tablesQuery = app.tables,
            tableElement = tablesQuery.element
        tableElement.swipeUp()
        tableElement.swipeDown()
    }
    
    func testTableAllUsersTapAndUserPage(){
        let tablesQuery = app.tables.matching(identifier: "allUsersTable")
        tablesQuery.element(boundBy: 0).cells.element(boundBy: 0).tap()
        let alluserrepostableTable = XCUIApplication().tables["allUserReposTable"]
        alluserrepostableTable.swipeUp()
        alluserrepostableTable.swipeDown()
        
        let scroll = XCUIApplication().scrollViews
        scroll.element.swipeUp()
        scroll.element.swipeDown()
    }
}
