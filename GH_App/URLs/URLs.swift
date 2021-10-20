//
//  AllLinks.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 21/09/2021.
//

import Foundation

class URLs{
    let allUsersURL = "https://api.github.com/users".encodeUrl,
        userURL = "https://api.github.com/users/\(chooseLogin)".encodeUrl,
        repoURL = "https://api.github.com/users/\(chooseLogin)/repos".encodeUrl,
        searchUserURL = "https://api.github.com/search/users?q=\(searchUserName)".encodeUrl
}
