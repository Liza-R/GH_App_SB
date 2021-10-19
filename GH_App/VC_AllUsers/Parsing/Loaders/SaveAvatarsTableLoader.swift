//
//  Load&SaveAvatarsTable.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 19/10/2021.
//

import Foundation
import Alamofire

class SaveAvatarsForTable{
    func uploadAvatarsAndSaveInfo(ava_urls: [String]){
        var all_avatars: [NSData] = []
        for i in ava_urls{
            AF.request(i ,method: .get).response{ response in
                switch response.result {
                    case .success(let responseData):
                    let ic = UIImage(data: responseData!, scale: 1) ?? .checkmark
                    all_avatars.append(ic.pngData()! as NSData)

                    if all_avatars.count == ava_urls.count{
                        SaveAvatars().savingAllUsersAvatars(avatars: all_avatars, urls: ava_urls)
                    }

                     case .failure(let error):
                        print("error---> avatar loading", error, response.response?.statusCode as Any)
                }
            }
        }
    }
}
