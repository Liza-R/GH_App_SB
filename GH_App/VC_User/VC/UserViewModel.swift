//
//  UserViewModel.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 21/09/2021.
//

import Foundation
import UIKit

class UserViewModel{
    private var user: UserInfo.Info_User?,
                user_repos: [[RepoInfo.Repo_Info]] = [[]],
                saveUI = SaveUserInfo()
    
    init(){
        uploadUserInfo()
    }

    func uploadUserInfo(){
        UserLoader().loadUserInfo{ user in
            self.user = user
            DispatchQueue.main.async{
                AvatarLoader().uploadAvatarsAndSaveInfo(ava_url: user.avatar_url, login: user.login, name: user.name ?? "Name Not Found", company: user.company ?? "Company Not Found", location: user.location ?? "Location Not Found", email: user.email ?? "E-mail Not Found", numRepos: user.public_repos, repoURL: user.repos_url, saveUI: self.saveUI)
            }
        }
        uploadReposInfo()
    }
    func uploadReposInfo(){
        var repo_names: [String] = [],
            repo_privates: [Bool] = [],
            description_repo: [String] = [],
            create_dates: [String] = [],
            update_dates: [String] = [],
            push_dates: [String] = [],
            lang_repo: [String] = []
        
        RepoLoader().loadRepoInfo{ repo in
            self.user_repos = repo
            DispatchQueue.main.async{
                for j in repo{
                    for i in j{
                        repo_names.append(i.name)
                        repo_privates.append(i.private)
                        description_repo.append(i.description ?? "Description Not Found")
                        create_dates.append(i.created_at)
                        update_dates.append(i.updated_at ?? "Date of create Not Found")
                        push_dates.append(i.pushed_at ?? "Date of puch Not Found")
                        lang_repo.append(i.language ?? "Languge Not Found")
                    }
                }
                self.saveUI.savingViewedUsersRepoInfo(repo_names: repo_names, repo_privates: repo_privates, description_repo: description_repo, create_dates: create_dates, update_dates: update_dates, push_dates: push_dates, lang_repo: lang_repo)
            }
        }
    }
}
