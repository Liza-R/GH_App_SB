//
//  RemoveOldUserInfo.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 20/10/2021.
//

import Foundation
class RemoveOldUserInfo{
    func removeOldUserInfo(){
        let modelCurrent = SaveUserInfo().realmUser.objects(ViewedUserDB.self)
        for i in modelCurrent{
            for j in i.user{
                if j.login == chooseLogin{
                    try! SaveUserInfo().realmUser.write {
                        SaveUserInfo().realmUser.delete(i)
                        print("user \(j.login) remove")
                    }
                }
            }
        }
    }
}
