//
//  UserStruct.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 21/09/2021.
//

import Foundation

class UserInfo{
    struct All_User_Info{
        var info_user: Info_User?
    }
    struct Info_User{
        var login: String,
            avatar_url: String,
            repos_url: String,
            name: String,
            company: String,
            location: String,
            public_repos: Int
    }
}
