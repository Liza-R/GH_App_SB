//
//  AvatarLoader.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 19/10/2021.
//

import Foundation
import Alamofire

class AvatarLoader{
    func uploadAvatarsAndSaveInfo(ava_url: String, cellImage: UIImageView){
        AF.request(ava_url ,method: .get).response{ response in
            switch response.result {
                case .success(let responseData):
                let ic = UIImage(data: responseData!, scale:1) ?? .checkmark
                    cellImage.image = ic
                //SaveAvatars().savingAllUsersAvatars(avatar: ic.pngData()! as NSData)
                
                 case .failure(let error):
                    print("error---> avatar loading", error, response.response?.statusCode as Any)
            }
        }
    }
}
