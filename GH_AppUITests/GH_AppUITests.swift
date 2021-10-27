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

    func testUserSearchBar(){
        let inputUserNameSearchField = app.searchFields["Input user name"]
        inputUserNameSearchField.tap()
        let lKey = app/*@START_MENU_TOKEN@*/.keys["L"]/*[[".keyboards.keys[\"L\"]",".keys[\"L\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        lKey.tap()
        let iKey = app/*@START_MENU_TOKEN@*/.keys["i"]/*[[".keyboards.keys[\"i\"]",".keys[\"i\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        iKey.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Done"]/*[[".keyboards",".buttons[\"done\"]",".buttons[\"Done\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        inputUserNameSearchField.tap()
        let zKey = app.keys["z"]
        zKey.tap()
        let aKey = app.keys["a"]
        aKey.tap()
        let clearTextButton = inputUserNameSearchField.buttons["Clear text"]
        clearTextButton.tap()
    }
    
    func testRefresh(){
        let tablesQuery = app.tables
        let firstCell = tablesQuery.firstMatch
        let start = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        let finish = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 2))
        start.press(forDuration: 0, thenDragTo: finish)
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
