//
//  RepoLoader.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 21/09/2021.
//

import Foundation
import Alamofire

class RepoLoader{
    func loadRepoInfo(completion: @escaping ([[RepoInfo.Repo_Info]]) -> Void){
        AF.request(URL(string: URLs().repoURL)!)
        .validate()
            .responseDecodable(of: [RepoInfo.Repo_Info].self) { (response) in
                let errors = response.error as Any
                print(String(describing: errors), "error --> load repo info", response.response?.statusCode as Any)
                guard let repo_info = response.value else { return }
                completion([repo_info])
        }
    }
}
