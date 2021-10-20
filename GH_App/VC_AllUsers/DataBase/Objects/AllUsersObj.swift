//
//  AllUsersObj.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 21/09/2021.
//

import Foundation
import RealmSwift

class AllUsersClass: Object {
    @objc dynamic var login = ""
    @objc dynamic var avatar_url = ""
}

class AllUsersInfoDB: Object{
    let users = List<AllUsersClass>()
}
