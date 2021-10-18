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

searchUserName = "",
chooseLogin = "",
startSearch = false

class ViewController: UIViewController {
    @IBOutlet weak var userSearchBar: UISearchBar!
    @IBOutlet weak var allUsersTable: UITableView!
    
    var usersLogins: [String] = [],
        usersAva: [String] = [],
        searchUsersLogins: [String] = [],
        searchUsersAva: [String] = [],
        searchResult: [String] = [],
        refreshControl = UIRefreshControl(),
        disposeBag = DisposeBag()
    
    let allUsersInfoRealm = ReturnInfoModels().returnAllUsers()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CheckDataBase().outputInfoFromDataBase(allUsersInfoRealm: allUsersInfoRealm, uploadNOEmptyUsersInfo: uploadNOEmptyUsersInfo)
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        refreshControl.tintColor = .white
        self.allUsersTable.addSubview(refreshControl)
        self.userSearchBar.delegate = self
        self.allUsersTable.rowHeight = 120
        self.allUsersTable.reloadData()
        self.allUsersTable.dataSource = self
    }

    @objc func refresh(_ sender: AnyObject) {
        ConnectionActions().checkIntenet(vc: self, allUsersTable: self.allUsersTable, uploadNOEmptyUsersInfo: uploadNOEmptyUsersInfo, allUsersInfoRealm: self.allUsersInfoRealm, refreshStatus: true, refresh: self.refreshControl)
    }
    
    func uploadNOEmptyUsersInfo(){
        if self.allUsersInfoRealm.isEmpty == false{
            let inAllUsers = self.allUsersInfoRealm.last!
            self.usersLogins.removeAll()
            self.usersAva.removeAll()
            for i in inAllUsers.logins{
                self.usersLogins.append(i.login)
            }
            for i in inAllUsers.avatar_urls{
                self.usersAva.append(i.avatar_url)
            }
        }else{
            print("DataBase is empty")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ConnectionActions().checkIntenet(vc: self, allUsersTable: self.allUsersTable, uploadNOEmptyUsersInfo: uploadNOEmptyUsersInfo, allUsersInfoRealm: self.allUsersInfoRealm, refreshStatus: false, refresh: self.refreshControl)
        
        savingAllUsers.asObservable().subscribe{ status in
            if status.element == true{
                RxMotions().allUsersSaving(allUsersTable: self.allUsersTable, uploadNOEmptyUsersInfo: self.uploadNOEmptyUsersInfo)
            }
        }.disposed(by: disposeBag)
        
        userSearchBar.rx.text.asObservable().subscribe{ searchS in
                if searchS.element == ""{
                    RxMotions().allUsersSaving(allUsersTable: self.allUsersTable, uploadNOEmptyUsersInfo: self.uploadNOEmptyUsersInfo)
                }else{}
        }.disposed(by: disposeBag)
        
        self.allUsersTable.rx.itemSelected
          .subscribe(onNext: { indexPath in
              RxMotions().openNewVC(vc: self, usersLogins: self.usersLogins, indPath: indexPath)
          }).disposed(by: disposeBag)
    }
}

extension ViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if Connectivity.isConnectedToInternet {
            startSearch = true
            searchUserName = userSearchBar.text ?? ""
            let viewModel = AllUsersViewModel()
            viewModel.infoSearchDelegate = self
            usersLogins = searchText.isEmpty ? searchResult: searchResult.filter{ (item: String) -> Bool in
                    return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
                }
            for (i, j) in searchUsersLogins.enumerated(){
                for (k, m) in usersLogins.enumerated(){
                    if j == m{
                        self.usersAva[k] = searchUsersAva[i]
                        self.usersLogins[k] = searchUsersLogins[i]
                    }
                }
            }
            self.allUsersTable.reloadData()
        }else{
            startSearch = false
            Alerts().offlineAlert(vc: self)
        }
    }
}

extension ViewController: uploadSearchUsersInfo {
    func uploadSearching(logins: [String], avatar_urls: [String]) {
        self.usersLogins = logins
        self.usersAva = avatar_urls
        self.searchResult = self.usersLogins
        self.allUsersTable.reloadData()
    }
}

extension ViewController: UITableViewDataSource{

    func tableView(_ tableView_Alam: UITableView, numberOfRowsInSection section: Int) -> Int {
        var countCells = 0
        if usersLogins.isEmpty{
            countCells = 1
        }else{
            countCells = usersLogins.count
        }
        return countCells
    }

    func tableView(_ tableView_Alam: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView_Alam.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! AllUsersTableViewCell
        
        if usersLogins.isEmpty{
            cell.userNameLabel.text = "User with login \(searchUserName) not found"
            cell.userImage.image = .none
        }else{
            cell.userNameLabel.text = usersLogins[indexPath.row]
            AvatarLoader().uploadAvatarsAndSaveInfo(ava_url: usersAva[indexPath.row], cellImage: cell.userImage)
        }
        return cell
    }
}
