//
//  UserViewModel.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 21/09/2021.
//

import Foundation

protocol uploadUserInfo{
    func uploadUInfo(login: String, avatar_url: String, repos_url: String, name: String, company: String, location: String, public_repos_c: Int, email: String)
}

class UserViewModel{
    private var user: UserInfo.Info_User?
    var infoUserDelegate: uploadUserInfo?
    
    init(){
        uploadUserInfo()
    }
    
    func uploadUserInfo(){
        UserLoader().loadUserInfo{ user in
            self.user = user
            DispatchQueue.main.async{
                self.infoUserDelegate?.uploadUInfo(login: user.login, avatar_url: user.avatar_url, repos_url: user.repos_url, name: user.name ?? "not found", company: user.company ?? "not found", location: user.location ?? "not found", public_repos_c: user.public_repos, email: user.email ?? "not found")
            }
        }
    }
}
