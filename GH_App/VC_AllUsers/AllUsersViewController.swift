//
//  ViewController.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 21/09/2021.
//

import UIKit
import RxCocoa
import RxSwift

var savingAllUsers = BehaviorRelay<Bool>(value: false)

class ViewController: UIViewController {
    @IBOutlet weak var userSearchBar: UISearchBar!
    @IBOutlet weak var allUsersTable: UITableView!
    
    var usersLogins: [String] = [],
        usersAva: [String] = [],
        
        refreshControl = UIRefreshControl(),
        
        disposeBag = DisposeBag()
    
    let allUsersInfoRealm = ReturnInfoModels().returnAllUsers()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        self.allUsersTable.addSubview(refreshControl)
        
        switch allUsersInfoRealm.isEmpty {
        case true:
            print("The database is empty. Trying to download new information")
        case false:
            uploadNOEmptyUsersInfo()
        }
        AllUsersViewModel().uploadAllUsersInfo()
        
        savingAllUsers.asObservable().subscribe{ status in
            if status.element == true{
                self.uploadNOEmptyUsersInfo()
                self.allUsersTable.reloadData()
            }else{}
        }.disposed(by: disposeBag)
        
        self.allUsersTable.reloadData()
        self.allUsersTable.dataSource = self
    }
    
    @objc func refresh(_ sender: AnyObject) {
        uploadNOEmptyUsersInfo()
        AllUsersViewModel().uploadAllUsersInfo()
        self.allUsersTable.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    func uploadNOEmptyUsersInfo(){
        let inAllUsers = self.allUsersInfoRealm.last!
        self.usersLogins.removeAll()
        self.usersAva.removeAll()
        
        for i in inAllUsers.logins{
            self.usersLogins.append(i.login)
        }
        for i in inAllUsers.avatar_urls{
            self.usersAva.append(i.avatar_url)
        }
    }
}


extension ViewController: UITableViewDataSource{

    func tableView(_ tableView_Alam: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersLogins.count
    }

    func tableView(_ tableView_Alam: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView_Alam.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! AllUsersTableViewCell,
            ava = AvatarLoader().avatarLoader(ava_url: usersAva[indexPath.row])
        
        cell.userNameLabel.text = usersLogins[indexPath.row]
        cell.userImage = ava
        
        return cell
    }
}
