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
        AF.request(URL(string: URLs().searchUserURL)!, method: .get)
        .validate()
        .responseDecodable(of: AllSearchUsers.All_Search_Info.self) { (response) in
            errorLoad.accept(response.response?.statusCode ?? 0)
            guard let all_search_users_info = response.value else { return }
                completion([all_search_users_info])
        }
    }
}
