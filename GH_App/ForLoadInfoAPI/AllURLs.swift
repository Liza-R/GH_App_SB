//
//  AllLinks.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 21/09/2021.
//

import Foundation

class URLs{
    let allUsersURL = "https://api.github.com/users".encodeUrl,
        userURL = "https://api.github.com/users/USERNAME".encodeUrl,
        repoURL = "https://api.github.com/users/USERNAME/repos".encodeUrl,
        searchUserURL = "https://api.github.com/search/users?q=\(searchUserName)".encodeUrl
}
extension String{
    var encodeUrl: String
    {
        return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
    var decodeUrl: String
    {
        return self.removingPercentEncoding!
    }
}
 
