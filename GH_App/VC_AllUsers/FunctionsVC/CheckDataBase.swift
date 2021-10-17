//
//  CheckDataBase.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 17/10/2021.
//

import Foundation
import RealmSwift
import UIKit

class CheckDataBase{
    func outputInfoFromDataBase(allUsersInfoRealm: Results<AllUsersInfoDB>, uploadNOEmptyUsersInfo: () -> Void, allUsersTable: UITableView){
        switch allUsersInfoRealm.isEmpty {
        case true:
            print("The database is empty")
        case false:
            print("The database is not empty. Upload old info")
            uploadNOEmptyUsersInfo()
        }
        AllUsersViewModel().uploadAllUsersInfo()
        allUsersTable.reloadData()
    }
}
