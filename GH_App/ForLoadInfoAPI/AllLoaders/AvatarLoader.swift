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
    func newAvatarLoader(ava_url: String, myImageView: UIImageView){
        AF.request(ava_url ,method: .get).response{ response in
        switch response.result {
             case .success(let responseData):
                 myImageView.image = UIImage(data: responseData!, scale:1)
             case .failure(let error):
            print("error---> avatar loading", error, response.response?.statusCode as Any)
             }
        }
    }
}
