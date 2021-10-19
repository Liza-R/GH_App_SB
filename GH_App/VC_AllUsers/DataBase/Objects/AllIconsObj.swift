//
//  AllIconsObj.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 19/10/2021.
//

import Foundation
import RealmSwift

class Avatar_URLs_ForAllUsersClass: Object{
    @objc dynamic var avatar_url_ = ""
}

class AvatarsForAllUsersClass: Object{
    @objc dynamic var avatar = NSData()
}

class AllUsersAvatarsDB: Object{
    let avatars = List<AvatarsForAllUsersClass>(),
        avatar_urls_ = List<Avatar_URLs_ForAllUsersClass>()
}
