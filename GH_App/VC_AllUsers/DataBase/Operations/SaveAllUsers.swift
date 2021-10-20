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
        let infoUser = AllUsersInfoDB()
        for (i, j) in logins.enumerated(){
            let user = AllUsersClass()
            user.login = j
            user.avatar = avatars[i]
            infoUser.users.append(user)
        }
        try! realm.write{
            realm.add(infoUser)
        }
        savingAllUsers.accept(true)
        RemoveOldInfo().removeOldUsersInfo()
    }
}
