//
//  RemoveOldInfo.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 21/09/2021.
//

import Foundation

class RemoveOldInfo{
    func removeOldUsersInfo(){
        let modelCurrent = SaveInfo().realm.objects(AllUsersInfoDB.self)
        if modelCurrent.first != nil && modelCurrent.count > 2{
            try! SaveInfo().realm.write {
                SaveInfo().realm.delete(modelCurrent.first!)
            }
        }
    }
    func removeOldAvatars(){
        let modelCurrent = SaveAvatars().realm.objects(AllUsersAvatarsDB.self)
        if modelCurrent.first != nil && modelCurrent.count > 2{
            try! SaveInfo().realm.write {
                SaveInfo().realm.delete(modelCurrent.first!)
            }
        }
    }
}
