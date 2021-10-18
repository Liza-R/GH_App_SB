//
//  UserLoader.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 21/09/2021.
//

import Foundation
import Alamofire

class UserLoader{
    func loadUserInfo(completion: @escaping (UserInfo.Info_User) -> Void){
        AF.request(URL(string: URLs().userURL)!)
        .validate()
            .responseDecodable(of: UserInfo.Info_User.self) { (response) in
                print(String(describing: response.error as Any), "error --> load user info", response.response?.statusCode as Any)
                guard let user_info = response.value else { return }
                completion(user_info)
        }
    }
}
