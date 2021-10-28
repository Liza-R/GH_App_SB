//
//  GH_App_Realm_Tests.swift
//  GH_AppTests
//
//  Created by Elizaveta Rogozhina on 28/10/2021.
//

import XCTest
import RealmSwift

@testable import GH_App

class GH_App_Realm_Tests: XCTestCase {
    var realm: Realm!
    
    override func setUp(){
        super.setUp()
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
        realm = try! Realm()
    }
    
    override class func tearDown() {
        super.tearDown()
    }
    
    func test_ShouldBeZero_Users(){
        let sut = AllUsersInfoDB()
        XCTAssertEqual(sut.users.count, 0, "count should be 0")
    }
    
    func test_AfterAddingNewUser(){
        let sv = SaveInfo()
        sv.realm = realm
        let logins = ["log1", "log2", "log3"]
        let images: [UIImage] = [.add, .actions, .checkmark]
        var avas: [NSData] = []
        for i in images{
            avas.append(i.pngData()! as NSData)
        }
        sv.savingAllUsersInfo(logins: logins, avatars: avas)
        let model_AllUsers = sv.realm.objects(AllUsersInfoDB.self)
        let model_User = sv.realm.objects(AllUsersClass.self)
        XCTAssertEqual(model_AllUsers.count, 1, "count should be 1")
        XCTAssertEqual(model_User.count, 3, "count should be 3")
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}
