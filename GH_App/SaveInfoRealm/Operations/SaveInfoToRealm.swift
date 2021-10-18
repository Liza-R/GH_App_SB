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
    
    func savingAllUsersInfo(logins: [String], avatars: [NSData]){
        print("-----Start save new info")
        let infoUser = AllUsersInfoDB()
        for i in logins{
            let login = LoginForAllUsersClass()
            login.login = i
            infoUser.logins.append(login)
        }
        for i in avatars{
            let ava = AvatarURLsForAllUsersClass()
            ava.avatar = i
            infoUser.avatars.append(ava)
        }
        try! realm.write{
            realm.add(infoUser)
        }
        print("-----Stop save new info")
        savingAllUsers.accept(true)
        RemoveOldInfo().removeOldUsersInfo()
    }
}
