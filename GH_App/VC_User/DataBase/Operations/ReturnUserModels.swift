//
//  ReturnUserModels.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 19/10/2021.
//

import Foundation
import RealmSwift

class ReturnUserInfoModels{
    func returnAllUserInfo() -> Results<ViewedUserDB>{
        return SaveUserInfo().realmUser.objects(ViewedUserDB.self)
    }
}
