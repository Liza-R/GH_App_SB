//
//  UserObj.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 21/09/2021.
//

import Foundation
import RealmSwift

class UserDB: Object{
    @objc dynamic var login = ""
    @objc dynamic var avatar_url = ""
    @objc dynamic var repos_url = ""
    @objc dynamic var name = ""
    @objc dynamic var company = ""
    @objc dynamic var location = ""
    @objc dynamic var public_repos = 0
}
