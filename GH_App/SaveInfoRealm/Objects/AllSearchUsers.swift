//
//  File.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 25/09/2021.
//

import Foundation
import RealmSwift

class LoginForAllSearchUsersClass: Object {
    @objc dynamic var login = ""
}
class AvatarURLsForAllSearchUsersClass: Object {
    @objc dynamic var avatar_url = ""
}

class AllSearchUsersInfoDB: Object{
    let logins = List<LoginForAllSearchUsersClass>(),
        avatar_urls = List<AvatarURLsForAllSearchUsersClass>()
}
