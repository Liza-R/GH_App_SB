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
        disposeBag = DisposeBag(),
        spin: Spinner?
    
    private let allUsersInfoRealm = ReturnInfoModels().returnAllUsers()
                
    override func viewDidLoad() {
        super.viewDidLoad()
        self.allUsersTable.accessibilityIdentifier = "allUsersTable"
        spin = Spinner()
        spin?.createSpinner(vc: self.view)
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        refreshControl.tintColor = .white
        self.allUsersTable.addSubview(refreshControl)
        self.userSearchBar.delegate = self
        self.allUsersTable.rowHeight = 120
        self.allUsersTable.dataSource = self
    }

    @objc func refresh(_ sender: AnyObject) {
        switch ConnectionActions().checkIntenet() {
        case true:
            self.uploadNOEmptyUsersInfo()
            spin?.stopSpinner()
        case false:
            Alerts().offlineAlert(vc: self)
        }
        refreshControl.endRefreshing()
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
        self.allUsersTable.keyboardDismissMode = .onDrag
        self.uploadNOEmptyUsersInfo()
        switch ConnectionActions().checkIntenet() {
        case true:
            AllUsersViewModel().uploadAllUsersInfo()
            savingAllUsers.asObservable().subscribe{ status in
                if status.element == true{
                    self.uploadNOEmptyUsersInfo()
                    self.spin?.stopSpinner()
                }
            }.disposed(by: disposeBag)
            errorLoad.asObservable().subscribe{ error in
                Alerts().error_Alert(vc: self, error: error.element ?? 0)
            }.disposed(by: disposeBag)
        case false:
            Alerts().offlineAlert(vc: self)
        }
        self.allUsersTable.rx.itemSelected.subscribe(onNext: { indexPath in
              RxMotions().openNewVC(vc: self, usersLogins: self.usersLogins, indPath: indexPath)
        }).disposed(by: disposeBag)
    }
}

extension ViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchVM = AllUsersViewModel()
        if searchText != ""{
            switch ConnectionActions().checkIntenet() {
            case true:
                self.startSearch = true
                searchUserName = searchText
                searchVM.infoSearchDelegate = self
                searchVM.searchUsersInfo()
            case false:
                Alerts().offlineAlert(vc: self)
            }
        }else{
            self.startSearch = false
            self.uploadNOEmptyUsersInfo()
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        self.userSearchBar.endEditing(true)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.userSearchBar.endEditing(true)
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
