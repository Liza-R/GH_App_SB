//
//  AvatarLoader.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 21/09/2021.
//

import Foundation
import UIKit
import AlamofireImage

class AvatarLoader{
    func avatarLoader(ava_url: String) -> UIImageView{
        let imageView = UIImageView(),
            url = URL(string: ava_url)!
        
        imageView.af.setImage(withURL: url)
        return imageView
    }
}
