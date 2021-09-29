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
    savingAllSearchUsers = BehaviorRelay<Bool>(value: false),

searchUserName = ""

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
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        refreshControl.tintColor = .white
        self.allUsersTable.addSubview(refreshControl)
        self.userSearchBar.delegate = self
        
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
        
        self.allUsersTable.rowHeight = 120
        self.allUsersTable.reloadData()
        self.allUsersTable.dataSource = self
    }
    
    @objc func refresh(_ sender: AnyObject) {
        switch allUsersInfoRealm.isEmpty {
        case true:
            print("The database is empty. Trying to download new information")
        case false:
            uploadNOEmptyUsersInfo()
            print("Refreshing allUsersTable")
        }
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

extension ViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
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
    }
}

extension ViewController: uploadSearchUsersInfo {
    func uploadSearching(logins: [String], avatar_urls: [String]) {
        print(avatar_urls)
        self.searchUsersAva = avatar_urls
        self.usersLogins = logins
        self.searchResult = self.usersLogins
        self.allUsersTable.reloadData()
    }
}

extension ViewController: UITableViewDataSource{

    func tableView(_ tableView_Alam: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersLogins.count
    }

    func tableView(_ tableView_Alam: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView_Alam.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! AllUsersTableViewCell
        
        cell.userNameLabel.text = usersLogins[indexPath.row]
        AvatarLoader().newAvatarLoader(ava_url: usersAva[indexPath.row], myImageView: cell.userImage)
        return cell
    }
}
