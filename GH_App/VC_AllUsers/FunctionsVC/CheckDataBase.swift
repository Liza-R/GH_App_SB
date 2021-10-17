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
            print("The database is empty. Trying to download new information")

        case false:
            uploadNOEmptyUsersInfo()
        }
        AllUsersViewModel().uploadAllUsersInfo()
        allUsersTable.reloadData()
    }
}
