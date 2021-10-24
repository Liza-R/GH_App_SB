//
//  CheckConnect.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 17/10/2021.
//

import Foundation
import Alamofire
class Connectivity{
    class var isConnectedToInternet: Bool{
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
