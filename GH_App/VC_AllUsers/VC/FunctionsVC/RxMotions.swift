//
//  RxVariablesMotions.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 17/10/2021.
//

import Foundation
import UIKit
import RealmSwift

class RxMotions{
    func allUsersSaving(allUsersTable: UITableView, uploadNOEmptyUsersInfo: @escaping() -> Void){
        uploadNOEmptyUsersInfo()
        allUsersTable.reloadData()
    }
    
    func openNewVC(vc: UIViewController, usersLogins: [String], indPath: IndexPath){
        chooseLogin = usersLogins[indPath.row]
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let newViewController = storyboard.instantiateViewController(withIdentifier: "UserViewController") as! UserViewController
        vc.present(newViewController, animated: true, completion: nil)
    }
}
