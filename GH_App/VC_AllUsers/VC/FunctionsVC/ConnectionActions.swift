//
//  ConnectionActions.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 17/10/2021.
//

import Foundation
import UIKit
import RealmSwift

class ConnectionActions{
    func checkIntenet() -> Bool{
        var connect = false
        if Connectivity.isConnectedToInternet{
                print("-Internet is available.")
            connect = true
        }else{
            print("-Internet is not available.")
            connect = false
        }
        return connect
    }
}
