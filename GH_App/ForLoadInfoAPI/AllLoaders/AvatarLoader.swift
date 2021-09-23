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
   /* func avatarLoader(ava_url: String) -> UIImageView{
        let imageView = UIImageView(),
            url = URL(string: ava_url)!
        imageView.af.setImage(withURL: url)
        print(imageView)
        return imageView
    }
    */
    func newAvatarLoader(ava_url: String, myImageView: UIImageView){
        AF.request(ava_url ,method: .get).response{ response in
        
        switch response.result {
             case .success(let responseData):
                 myImageView.image = UIImage(data: responseData!, scale:1)

             case .failure(let error):
                 print("error--->",error)
             }
        }
    }
}
