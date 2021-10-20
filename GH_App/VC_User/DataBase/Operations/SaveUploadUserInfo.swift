//
//  SaveUploadInfo.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 19/10/2021.
//

import Foundation
import RealmSwift

class SaveUserInfo{
    let realmUser = try! Realm(),
        infoViewUser = ViewedUserDB()/*,
        allUsers = AllViewedUsersDB()*/
    
    func savingViewedUsersInfo(login: String, name: String, company: String, location: String, email: String, numRepos: Int, repoURL: String, avaURL: String){
        let user_ = UserClass()
        user_.login = login
        user_.numRepos = numRepos
        user_.company = company
        user_.avaURL = avaURL
        user_.email = email
        user_.reposURL = repoURL
        user_.location = location
        user_.name = name
        infoViewUser.user.append(user_)
    }
    
    func savingViewedUsersRepoInfo(repo_names: [String], repo_privates: [Bool], description_repo: [String], create_dates: [String], update_dates: [String], push_dates: [String], lang_repo: [String]){
        for (i, j) in repo_names.enumerated(){
            let userRepo_ = UserRepoTableClass()
            userRepo_.repo_name = j
            userRepo_.lang_repo = lang_repo[i]
            userRepo_.description_repo = description_repo[i]
            userRepo_.create_date = create_dates[i]
            userRepo_.push_date = push_dates[i]
            userRepo_.update_date = update_dates[i]
            userRepo_.repo_private = repo_privates[i]
            infoViewUser.repos_user.append(userRepo_)
        }
        //allUsers.users.append(infoViewUser)
        try! realmUser.write{
            realmUser.add(infoViewUser)//allUsers)
        }
        savingUserInfo.accept(true)
    }
}
