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
        for (i, j) in logins.enumerated(){
            let user = AllUsersClass()
            user.login = j
            user.avatar_url = avatar_urls[i]
            infoUser.users.append(user)
        }
        try! realm.write{
            realm.add(infoUser)
        }
        savingAllUsers.accept(true)
        RemoveOldInfo().removeOldUsersInfo()
    }
}
