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
        print("-Start check connect status")
        if Connectivity.isConnectedToInternet {
                print("--Yes! internet is available.")
            if refreshStatus == true{
                CheckDataBase().outputInfoFromDataBase(allUsersInfoRealm: allUsersInfoRealm, uploadNOEmptyUsersInfo: uploadNOEmptyUsersInfo)
                allUsersTable.reloadData()
                refresh.endRefreshing()
            }
        }else{
            print("--No! internet is notavailable.")
            Alerts().offlineAlert(vc: vc)
            if refreshStatus == true{
                refresh.endRefreshing()
            }
        }
        print("-Stop check connect status")
    }
}
