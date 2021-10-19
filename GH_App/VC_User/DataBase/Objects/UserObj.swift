//
//  UserObj.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 19/10/2021.
//

import Foundation
import RealmSwift

class UserClass: Object {
    @objc dynamic var login = ""
    @objc dynamic var name = ""
    @objc dynamic var company = ""
    @objc dynamic var location = ""
    @objc dynamic var numRepos = 0
    @objc dynamic var email = ""
    @objc dynamic var reposURL = ""
    @objc dynamic var avaURL = ""
}

class ViewedUserDB: Object{
    let user = List<UserClass>()
}

class AllViewedUsersDB: Object{
    let users = List<ViewedUserDB>()
}
