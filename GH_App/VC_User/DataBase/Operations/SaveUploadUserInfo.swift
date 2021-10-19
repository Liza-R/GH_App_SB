//
//  SaveUploadInfo.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 19/10/2021.
//

import Foundation
import RealmSwift

class SaveUserInfo{
    let realmUser = try! Realm()
    
    func savingViewedUsersInfo(login: String, name: String, company: String, location: String, email: String, numRepos: Int, repoURL: String, avaURL: String){
        let infoViewUser = ViewedUserDB(),
            user_ = UserClass()
            
        user_.login = login
        user_.numRepos = numRepos
        user_.company = company
        user_.avaURL = avaURL
        user_.email = email
        user_.reposURL = repoURL
        user_.location = location
        user_.name = name
        
        infoViewUser.user.append(user_)

        try! realmUser.write{
            realmUser.add(infoViewUser)
            //allViewedUsers.users.append(infoViewUser)
            //realmUser.add(allViewedUsers)
        }
        savingUserInfo.accept(true)
    }
}
