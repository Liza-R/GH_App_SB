//
//  AllUsersObj.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 21/09/2021.
//

import Foundation
import RealmSwift

class LoginForAllUsersClass: Object {
    @objc dynamic var login = ""
}
class AvatarURLsForAllUsersClass: Object {
    @objc dynamic var avatar = NSData()
}

class AllUsersInfoDB: Object{
    let logins = List<LoginForAllUsersClass>(),
        avatars = List<AvatarURLsForAllUsersClass>()
}
