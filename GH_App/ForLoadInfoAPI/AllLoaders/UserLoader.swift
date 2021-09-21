//
//  UserLoader.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 21/09/2021.
//

import Foundation
import Alamofire

class UserLoader{
    func loadUserInfo(completion: @escaping ([UserInfo.All_User_Info]) -> Void){
        AF.request(URL(string: URLs().userURL)!)
        .validate()
            .responseDecodable(of: UserInfo.All_User_Info.self) { (response) in
                let errors = response.error as Any
                print(String(describing: errors))
                guard let user_info = response.value else { return }
                completion([user_info])
        }
    }
}
