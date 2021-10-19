//
//  SaveAllAvatars.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 19/10/2021.
//

import Foundation
import RealmSwift

class SaveAvatars{
    let realm = try! Realm()
    func savingAllUsersAvatars(avatars: [NSData], urls: [String]){
        let avatarsUser = AllUsersAvatarsDB()
        for i in avatars{
            let ava = AvatarsForAllUsersClass()
            ava.avatar = i
            avatarsUser.avatars.append(ava)
        }
        for i in urls{
            let url = Avatar_URLs_ForAllUsersClass()
            url.avatar_url_ = i
            avatarsUser.avatar_urls_.append(url)
        }
        try! realm.write{
            realm.add(avatarsUser)
        }
        RemoveOldInfo().removeOldAvatars()
    }
}
