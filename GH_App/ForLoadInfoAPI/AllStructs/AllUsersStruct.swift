//
//  UsersStruct.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 21/09/2021.
//

import Foundation

class UsersInfo{
    struct All_Users{
        var all_users: [All_Users_Mass?]
    }
    struct All_Users_Mass{
        var info_mass: Info_Mass?
    }
    struct Info_Mass{
        var login: String,
            avatar_url: String
    }
}
