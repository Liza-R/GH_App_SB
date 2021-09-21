//
//  RepoStruct.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 21/09/2021.
//

import Foundation

class RepoInfo{
    struct All_Repo_Info: Decodable{
        var info_repo: [Info_Repo_Mass?]
    }
    struct Info_Repo_Mass: Decodable{
        var info_repo_mass: [Repo_Info?]
    }
    struct Repo_Info: Decodable{
        var name: String,
            `private`: Bool,
            description: String,
            languages_url: String,
            created_at: String,
            updated_at: String,
            pushed_at: String
    }
}
