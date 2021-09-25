//
//  SearchResultsLoader.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 25/09/2021.
//

import Foundation
import Alamofire

class AllSearchUsersLoader{
    func loadAllSearchUsersInfo(completion: @escaping ([[AllSearchUsers.SearchUsers_Mass]]) -> Void){
        AF.request(URL(string: URLs().allUsersURL)!)
        .validate()
        .responseDecodable(of: [AllSearchUsers.SearchUsers_Mass].self) { (response) in
                let errors = response.error as Any
                print(String(describing: errors), "error --> load all users info")
            
            guard let all_search_users_info = response.value else { return }
                completion([all_search_users_info])
        }
    }
}
