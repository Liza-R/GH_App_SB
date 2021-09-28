//
//  SearchResultsLoader.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 25/09/2021.
//

import Foundation
import Alamofire

class AllSearchUsersLoader{
    func loadAllSearchUsersInfo(completion: @escaping ([AllSearchUsers.All_Search_Info]) -> Void){
        AF.request(URL(string: URLs().searchUserURL)!)
        .validate()
        .responseDecodable(of: AllSearchUsers.All_Search_Info.self) { (response) in
                let errors = response.error as Any
                print(String(describing: errors), "error --> load seraching user")
            
            guard let all_search_users_info = response.value else { return }
                completion([all_search_users_info])
        }
    }
}
