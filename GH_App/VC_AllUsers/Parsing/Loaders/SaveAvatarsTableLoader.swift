//
//  Load&SaveAvatarsTable.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 19/10/2021.
//

import Foundation
import Alamofire
import AlamofireImage

class LoadAvatarsAndSaveInfoForTable{
    func uploadAvatarsAndSaveInfo(ava_urls: [String], logins: [String]){
        var all_avatars: [NSData] = [],
            c = 0
        all_avatars.append(contentsOf: repeatElement(NSData(), count: ava_urls.count))
        let imageCache = AutoPurgingImageCache()
        for (i, j) in ava_urls.enumerated(){
            AF.request(j ,method: .get).response{ response in
                switch response.result {
                    case .success(let responseData):
                    let ic = UIImage(data: responseData!, scale: 1) ?? .checkmark
                    imageCache.add(ic, withIdentifier: "\(j)")
                    c += 1
                    if c == ava_urls.count{
                        let ics = imageCache.image(withIdentifier: "\(j)") ?? .checkmark
                        all_avatars[i] = ics.pngData()! as NSData
                        SaveInfo().savingAllUsersInfo(logins: logins, avatars: all_avatars)
                    }else{
                        let ics = imageCache.image(withIdentifier: "\(j)") ?? .checkmark
                        all_avatars[i] = ics.pngData()! as NSData
                    }
                    
                     case .failure(let error):
                        print("error---> avatar loading", error, response.response?.statusCode as Any)
                }
            }
        }
    }
}
