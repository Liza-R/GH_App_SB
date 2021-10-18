//
//  SaveInfoToRealm.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 21/09/2021.
//

import Foundation
import RealmSwift

class SaveInfo{
    let realm = try! Realm()
    
    func savingAllUsersInfo(logins: [String], avatar_urls: [String]){
        let infoUser = AllUsersInfoDB()
        for i in logins{
            let login = LoginForAllUsersClass()
            login.login = i
            infoUser.logins.append(login)
        }
        for i in avatar_urls{
            let ava = AvatarURLsForAllUsersClass()
            ava.avatar_url = i
            infoUser.avatar_urls.append(ava)
        }
        try! realm.write{
            realm.add(infoUser)
        }
        savingAllUsers.accept(true)
        RemoveOldInfo().removeOldUsersInfo()
    }
}
