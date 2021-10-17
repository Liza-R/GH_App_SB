//
//  ViewModel.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 21/09/2021.
//

import Foundation

protocol uploadSearchUsersInfo{
    func uploadSearching(logins: [String], avatar_urls: [String])
}

class AllUsersViewModel{
    private var all_users: [[AllUsersInfo.Info_Mass]] = [[]],
                all_search_users: [AllSearchUsers.All_Search_Info] = []
    
    var infoSearchDelegate: uploadSearchUsersInfo?
    
    init(){
        if startSearch == true{
            searchUsersInfo()
            startSearch = false
        }else{}
    }
    
    func uploadAllUsersInfo(){
        var logins: [String] = [],
            ava_urls: [String] = []
        
        AllUsersLoader().loadAllUsersInfo{ all_users in
            self.all_users = all_users
            DispatchQueue.main.async {
                for i in all_users{
                    for j in i{
                        logins.append(j.login)
                        ava_urls.append(j.avatar_url)
                    }
                }
            AvatarLoader().uploadAvatarsAndSaveInfo(ava_urls: ava_urls, user_logins: logins)
            }
        }
    }
    
    func searchUsersInfo(){
        var logins: [String] = [],
            avatar_urls: [String] = []
        
        AllSearchUsersLoader().loadAllSearchUsersInfo { all_search_users in
            self.all_search_users = all_search_users
            DispatchQueue.main.async {
                for i in all_search_users{
                        for k in i.items{
                            logins.append(k?.login ?? "Login Not Found")
                            avatar_urls.append(k?.avatar_url ?? "Avatar Not Found")
                    }
                }
                self.infoSearchDelegate?.uploadSearching(logins: logins, avatar_urls: avatar_urls)
            }
        }
    }
}
