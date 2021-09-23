//
//  ViewModel.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 21/09/2021.
//

import Foundation

class AllUsersViewModel{
    private var all_users: [[AllUsersInfo.Info_Mass]] = [[]]
    
    func uploadAllUsersInfo(){
        var logins: [String] = [],
            avatar_urls: [String] = []
        
        AllUsersLoader().loadAllUsersInfo { all_users in
            self.all_users = all_users
            DispatchQueue.main.async {
                for i in all_users{
                    for j in i{
                        logins.append(j.login)
                        avatar_urls.append(j.avatar_url)
                    }
                }
                SaveInfo().savingAllUsersInfo(logins: logins, avatar_urls: avatar_urls)
            }
        }
    }
}
