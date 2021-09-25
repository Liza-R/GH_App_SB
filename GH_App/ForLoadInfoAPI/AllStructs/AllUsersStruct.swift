//
//  UsersStruct.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 21/09/2021.
//

import Foundation

class AllUsersInfo{
    struct Info_Mass: Decodable{
        var login: String,
            avatar_url: String
    }
}
