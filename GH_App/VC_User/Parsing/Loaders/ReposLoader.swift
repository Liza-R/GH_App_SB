//
//  ReposLoader.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 20/10/2021.
//

import Foundation
import Alamofire

class RepoLoader{
    func loadRepoInfo(completion: @escaping ([[RepoInfo.Repo_Info]]) -> Void){
        AF.request(URL(string: URLs().repoURL)!)
        .validate()
            .responseDecodable(of: [RepoInfo.Repo_Info].self) { (response) in
                print(String(describing: response.error as Any), "error --> load repo info", response.response?.statusCode as Any)
                guard let repo_info = response.value else { return }
                completion([repo_info])
        }
    }
}
