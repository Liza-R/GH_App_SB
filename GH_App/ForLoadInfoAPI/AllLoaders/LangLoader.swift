//
//  LangLoader.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 21/09/2021.
//

import Foundation
import Alamofire

class LangLoader{
    func loadRepoInfo(completion: @escaping ([LangInfo.Lang_Repo_Info]) -> Void){
        AF.request(URL(string: URLs().langRepo)!)
        .validate()
        .responseDecodable(of: LangInfo.Lang_Repo_Info.self) { (response) in
                let errors = response.error as Any
                print(String(describing: errors))
                guard let lang_info = response.value else { return }
                completion([lang_info])
        }
    }
}
