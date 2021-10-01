//
//  UserViewModel.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 21/09/2021.
//

import Foundation

protocol uploadUserInfo{
    func uploadUInfo(login: String, avatar_url: String, repos_url: String, name: String, company: String, location: String, public_repos_c: Int, email: String)
    func uploadRepos(repo_names: [String], repo_privates: [Bool], description: [String], create_dates: [String], update_dates: [String], push_dates: [String], lang_repo: [String])
}

class UserViewModel{
    private var user: UserInfo.Info_User?,
                user_repos: [[RepoInfo.Repo_Info]] = [[]]
    var infoUserDelegate: uploadUserInfo?
    
    init(){
        uploadUserInfo()
        uploadReposInfo()
    }
    
    func uploadUserInfo(){
        UserLoader().loadUserInfo{ user in
            self.user = user
            DispatchQueue.main.async{
                self.infoUserDelegate?.uploadUInfo(login: user.login, avatar_url: user.avatar_url, repos_url: user.repos_url, name: user.name ?? "not found", company: user.company ?? "not found", location: user.location ?? "not found", public_repos_c: user.public_repos, email: user.email ?? "not found")
            }
        }
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
                        update_dates.append(i.updated_at)
                        push_dates.append(i.pushed_at)
                        lang_repo.append(i.language ?? "Languge Not Found")
                    }
                }
                self.infoUserDelegate?.uploadRepos(repo_names: repo_names, repo_privates: repo_privates, description: description_repo, create_dates: create_dates, update_dates: update_dates, push_dates: push_dates, lang_repo: lang_repo)
            }
        }
    }
}
