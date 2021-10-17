//
//  AvatarLoader.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 21/09/2021.
//

import Foundation
import UIKit
import Alamofire

class AvatarLoader{
    func uploadAvatarsAndSaveInfo(ava_urls: [String], user_logins: [String]){
        var avatars: [NSData] = []
        for (_, j) in ava_urls.enumerated(){
            AF.request(j ,method: .get).response{ response in
            switch response.result {
            case .success(let responseData):
                let icon = UIImage(data: responseData!, scale:1) ?? .checkmark
                avatars.append(NSData(data: icon.pngData()!))
                if avatars.count == user_logins.count{
                    SaveInfo().savingAllUsersInfo(logins: user_logins, avatars: avatars)
                }
                
                 case .failure(let error):
                print("error---> avatar loading", error, response.response?.statusCode as Any)
                 }
            }
        }
    }
}
