//
//  AllUsersLoader.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 21/09/2021.
//

import Foundation
import Alamofire

class AllUsersLoader{
    func loadAllUsersInfo(completion: @escaping ([AllUsersInfo.All_Users]) -> Void){
        AF.request(URL(string: URLs().allUsersURL)!)
        .validate()
            .responseDecodable(of: AllUsersInfo.All_Users.self) { (response) in
                let errors = response.error as Any
                print(String(describing: errors))
                guard let all_users_info = response.value else { return }
                completion([all_users_info])
        }
    }
}
