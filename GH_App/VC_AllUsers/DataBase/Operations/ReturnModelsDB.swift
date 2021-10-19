//
//  ReturnModelsDB.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 21/09/2021.
//

import Foundation
import RealmSwift
import RxRealm
import RxCocoa
import RxSwift

class ReturnInfoModels{
    func returnAllUsers() -> Results<AllUsersInfoDB>{
        return SaveInfo().realm.objects(AllUsersInfoDB.self)
    }
    func returnAllAvatars() -> Results<AllUsersAvatarsDB>{
        return SaveAvatars().realm.objects(AllUsersAvatarsDB.self)
    }
}
