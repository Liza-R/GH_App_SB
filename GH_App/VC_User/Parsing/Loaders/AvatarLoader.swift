//
//  AvatarLoader.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 19/10/2021.
//

import Foundation
import Alamofire

class AvatarLoader{
    func uploadAvatarsAndSaveInfo(ava_url: String, login: String, name: String, company: String, location: String, email: String, numRepos: Int, repoURL: String, saveUI: SaveUserInfo){
        AF.request(ava_url ,method: .get).response{ response in
            switch response.result {
                case .success(let responseData):
                let ic = UIImage(data: responseData!, scale:1) ?? .checkmark
                let ava = ic.pngData()! as NSData
                saveUI.savingViewedUsersInfo(login: login, name: name, company: company, location: location, email: email, numRepos: numRepos, repoURL: repoURL, ava: ava)
                
                 case .failure(let error):
                    print("error---> avatar loading", error, response.response?.statusCode as Any)
            }
        }
    }
}
