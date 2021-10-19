//
//  AvatarLoader.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 21/09/2021.
//

import Foundation
import UIKit
import Alamofire

class AvatarsLoaderForTable{
    func uploadAvatarsTable(ava_url: String, cellImage: UIImageView){
        AF.request(ava_url ,method: .get).response{ response in
            switch response.result {
                case .success(let responseData):
                    cellImage.image = UIImage(data: responseData!, scale:1) ?? .checkmark
                 case .failure(let error):
                    print("error---> avatar loading", error, response.response?.statusCode as Any)
            }
        }
    }
}
