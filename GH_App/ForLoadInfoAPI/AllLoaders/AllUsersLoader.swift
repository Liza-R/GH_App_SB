//
//  AllUsersLoader.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 21/09/2021.
//

import Foundation
import Alamofire

class AllUsersLoader{
    func loadAllUsersInfo(completion: @escaping ([[AllUsersInfo.Info_Mass]]) -> Void){
        AF.request(URL(string: URLs().allUsersURL)!, method: .get)
        .validate()
        .responseDecodable(of: [AllUsersInfo.Info_Mass].self) { (response) in
            print(String(describing: response.error as Any), "error --> load all users info", response.response?.statusCode as Any)
            guard let all_users_info = response.value else { return }
                completion([all_users_info])
        }
    }
}
