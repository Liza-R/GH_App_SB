//
//  UsersStruct.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 21/09/2021.
//

import Foundation

class AllUsersInfo{
    struct All_Users: Decodable{
        var all_users: [All_Users_Mass?]
    }
    struct All_Users_Mass: Decodable{
        var info_mass: Info_Mass?
    }
    struct Info_Mass: Decodable{
        var login: String,
            avatar_url: String
    }
}
