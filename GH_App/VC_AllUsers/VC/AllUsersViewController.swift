//
//  ViewController.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 21/09/2021.
//

import UIKit
import RxCocoa
import RxSwift

var savingAllUsers = BehaviorRelay<Bool>(value: false),
    errorLoad = BehaviorRelay<Int>(value: 0),
    searchUserName = "",
    chooseLogin = ""

class ViewController: UIViewController {
    @IBOutlet weak var userSearchBar: UISearchBar!
    @IBOutlet weak var allUsersTable: UITableView!
    
    private var usersLogins: [String] = [],
        usersSearchAvaURLs: [String] = [],
        usersAvas: [NSData] = [],
        refreshControl = UIRefreshControl(),
        startSearch = false,
        disposeBag = DisposeBag()
    
    private let allUsersInfoRealm = ReturnInfoModels().returnAllUsers()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CheckDataBase().outputInfoFromDataBase(allUsersInfoRealm: allUsersInfoRealm, uploadNOEmptyUsersInfo: uploadNOEmptyUsersInfo)
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        refreshControl.tintColor = .white
        self.allUsersTable.addSubview(refreshControl)
        self.userSearchBar.delegate = self
        self.allUsersTable.rowHeight = 120
        self.allUsersTable.dataSource = self
    }

    @objc func refresh(_ sender: AnyObject) {
        ConnectionActions().checkIntenet(vc: self, allUsersTable: self.allUsersTable, uploadNOEmptyUsersInfo: uploadNOEmptyUsersInfo, allUsersInfoRealm: self.allUsersInfoRealm, refreshStatus: true, refresh: self.refreshControl)
    }
    
    func uploadNOEmptyUsersInfo(){
        if !self.allUsersInfoRealm.isEmpty{
            let inAllUsers = self.allUsersInfoRealm.last!
            self.usersLogins.removeAll()
            for i in inAllUsers.users{
                self.usersLogins.append(i.login)
                self.usersAvas.append(i.avatar)
            }
        }
        self.allUsersTable.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ConnectionActions().checkIntenet(vc: self, allUsersTable: self.allUsersTable, uploadNOEmptyUsersInfo: uploadNOEmptyUsersInfo, allUsersInfoRealm: self.allUsersInfoRealm, refreshStatus: false, refresh: self.refreshControl)
        
        savingAllUsers.asObservable().subscribe{ status in
            if status.element == true{
                RxMotions().allUsersSaving(allUsersTable: self.allUsersTable, uploadNOEmptyUsersInfo: self.uploadNOEmptyUsersInfo)
            }
        }.disposed(by: disposeBag)

        errorLoad.asObservable().subscribe{ error in
            Alerts().error_Alert(vc: self, error: error.element ?? 0)
        }.disposed(by: disposeBag)
        
        self.allUsersTable.rx.itemSelected.subscribe(onNext: { indexPath in
              RxMotions().openNewVC(vc: self, usersLogins: self.usersLogins, indPath: indexPath)
        }).disposed(by: disposeBag)
    }
}

extension ViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != ""{
            if Connectivity.isConnectedToInternet{
                self.startSearch = true
                searchUserName = searchText
                AllUsersViewModel().infoSearchDelegate = self
            }else{
                Alerts().offlineAlert(vc: self)
            }
        }else{
            self.startSearch = false
            self.uploadNOEmptyUsersInfo()
        }
    }
}

extension ViewController: uploadSearchUsersInfo{
    func uploadSearching(logins: [String], avatar_urls: [String]) {
        self.usersLogins = logins
        self.usersSearchAvaURLs = avatar_urls
        self.allUsersTable.reloadData()
    }
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView_Alam: UITableView, numberOfRowsInSection section: Int) -> Int {
        var countCells = 0
        if !usersLogins.isEmpty{
            countCells = usersLogins.count
        }else{
            countCells = 1
        }
        return countCells
    }

    func tableView(_ tableView_Alam: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView_Alam.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! AllUsersTableViewCell
        if usersLogins.isEmpty{
            cell.userNameLabel.text = "Info Not Found"
            cell.userImage.image = .none
        }else{
            cell.userNameLabel.text = usersLogins[indexPath.row]
            if startSearch == true{
                AvatarsLoaderForTable().uploadAvatarsTable(ava_url: usersSearchAvaURLs[indexPath.row], cellImage: cell.userImage)
            }else{
               cell.userImage.image = UIImage(data: usersAvas[indexPath.row] as Data)
            }
        }
        return cell
    }
}
