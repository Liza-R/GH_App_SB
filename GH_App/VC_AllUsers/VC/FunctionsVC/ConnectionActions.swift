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
    func checkIntenet(vc: UIViewController, allUsersTable: UITableView, uploadNOEmptyUsersInfo: () -> Void, allUsersInfoRealm: Results<AllUsersInfoDB>, refreshStatus: Bool, refresh: UIRefreshControl){
        if Connectivity.isConnectedToInternet {
                print("-Internet is available.")
            if refreshStatus == true{
                CheckDataBase().outputInfoFromDataBase(allUsersInfoRealm: allUsersInfoRealm, uploadNOEmptyUsersInfo: uploadNOEmptyUsersInfo)
                refresh.endRefreshing()
            }
        }else{
            print("-Internet is not available.")
            Alerts().offlineAlert(vc: vc)
            if refreshStatus == true{
                refresh.endRefreshing()
            }
        }
    }
}
