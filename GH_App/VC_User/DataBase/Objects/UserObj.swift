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

class UserRepoTableClass: Object {
    @objc dynamic var repo_name = ""
    @objc dynamic var repo_private = false
    @objc dynamic var description_repo = ""
    @objc dynamic var create_date = ""
    @objc dynamic var update_date = ""
    @objc dynamic var push_date = ""
    @objc dynamic var lang_repo = ""
}

class ViewedUserDB: Object{
    let user = List<UserClass>(),
        repos_user = List<UserRepoTableClass>()
}
