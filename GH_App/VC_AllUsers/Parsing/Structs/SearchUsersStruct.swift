//
//  SearchUsersStruct.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 25/09/2021.
//

import Foundation

class AllSearchUsers{
    struct All_Search_Info: Decodable{
        var items: [SearchUsers_Mass?]
    }
    
    struct SearchUsers_Mass: Decodable{
        var login: String,
            avatar_url: String
    }
}
