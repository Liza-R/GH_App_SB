//
//  SaveUploadInfo.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 19/10/2021.
//

import Foundation
import RealmSwift

class SaveUserInfo{
    let realm = try! Realm()
    
    func savingViewedUsersInfo(login: String, name: String, company: String, location: String, email: String, numRepos: Int, repoURL: String, avaURL: String){
        let infoUser = ViewedUsersDB(),
            login_ = LoginUserClass(),
            name_ = NameUserClass(),
            company_ = CompanyUserClass(),
            email_ = EmailUserClass(),
            location_ = LocationUserClass(),
            numRepo_ = NumPubReposUserClass(),
            repoURL_ = ReposURLUserClass(),
            avaURL_ = AvatarURLUserClass()
        
        login_.login = login
        name_.name = name
        company_.company = company
        location_.location = location
        numRepo_.numRepos = numRepos
        email_.email = email
        repoURL_.reposURL = repoURL
        
        infoUser.logins.append(login_)
        infoUser.names.append(name_)
        infoUser.company.append(company_)
        infoUser.locations.append(location_)
        infoUser.numsRepos.append(numRepo_)
        infoUser.emails.append(email_)
        infoUser.reposURLS.append(repoURL_)
        
        avaURL_.avaURL = avaURL
        infoUser.avaURLs.append(avaURL_)
        
        try! realm.write{
            realm.add(infoUser)
        }
        savingUserInfo.accept(true)
    }
}
