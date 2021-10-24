//
//  SaveUploadInfo.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 19/10/2021.
//

import Foundation
import RealmSwift
import RxCocoa
import RxSwift

class SaveUserInfo{
    let realmUser = try! Realm(),
        infoViewUser = ViewedUserDB(),
        disposeBag = DisposeBag()
    private var saveMainUserInfo = BehaviorRelay<Bool>(value: false)
    
    func savingViewedUsersInfo(login: String, name: String, company: String, location: String, email: String, numRepos: Int, repoURL: String, ava: NSData){
        let user_ = UserClass()
        user_.login = login
        user_.numRepos = numRepos
        user_.company = company
        user_.ava = ava
        user_.email = email
        user_.reposURL = repoURL
        user_.location = location
        user_.name = name
        print("start append user info")
        infoViewUser.user.append(user_)
        print("stop append user info")
        saveMainUserInfo.accept(true)
    }
    
    func savingViewedUsersRepoInfo(repo_names: [String], repo_privates: [Bool], description_repo: [String], create_dates: [String], update_dates: [String], push_dates: [String], lang_repo: [String]){
        saveMainUserInfo.asObservable().subscribe{ status in
            if status.element == true{
                for (i, j) in repo_names.enumerated(){
                    let userRepo_ = UserRepoTableClass()
                    userRepo_.repo_name = j
                    userRepo_.lang_repo = lang_repo[i]
                    userRepo_.description_repo = description_repo[i]
                    userRepo_.create_date = create_dates[i]
                    userRepo_.push_date = push_dates[i]
                    userRepo_.update_date = update_dates[i]
                    userRepo_.repo_private = repo_privates[i]
                    self.infoViewUser.repos_user.append(userRepo_)
                }
                RemoveOldUserInfo().removeOldUserInfo()
                print("append user repos info")
                try! self.realmUser.write{
                    self.realmUser.add(self.infoViewUser)
                }
                savingUserInfo.accept(true)
                print("write all user info")
            }
        }.disposed(by: disposeBag)
    }
}
