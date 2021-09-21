//
//  ViewModel.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 21/09/2021.
//

import Foundation

class AllUsersViewModel{
    private var all_users: [AllUsersInfo.All_Users] = []
    
    func uploadAllUsersInfo(){
        var logins: [String] = [],
            avatar_urls: [String] = []
        
        AllUsersLoader().loadAllUsersInfo { all_users in
            self.all_users = all_users
            DispatchQueue.main.async {
                for i in all_users{
                    for j in i.all_users{
                        logins.append(j?.info_mass?.login ?? "Login Not Found")
                        avatar_urls.append(j?.info_mass?.avatar_url ?? "Avatar URL Not Found")
                    }
                }
                SaveInfo().savingAllUsersInfo(logins: logins, avatar_urls: avatar_urls)
            }
        }
    }
}
