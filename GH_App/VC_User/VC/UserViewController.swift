//
//  UserViewController.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 21/09/2021.
//

import UIKit
import RxCocoa
import RxSwift

var savingUserInfo = BehaviorRelay<Bool>(value: false)

class UserViewController: UIViewController {
    @IBOutlet weak var userIcon: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var PubReposCountLabel: UILabel!
    @IBOutlet weak var allReposTable: UITableView!
    
    private var repo_names: [String] = [],
        repo_privates: [Bool] = [],
        description_repo: [String] = [],
        create_dates: [String] = [],
        update_dates: [String] = [],
        push_dates: [String] = [],
        lang_repo: [String] = [],
        disposeBag = DisposeBag()
    
    private let userInfoDB = ReturnUserInfoModels().returnAllUserInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserViewModel().infoUserDelegate = self
        UserViewModel().uploadUserInfo()
        self.allReposTable.rowHeight = 160
        self.allReposTable.reloadData()
        self.allReposTable.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        savingUserInfo.asObservable().subscribe{ status in
            if status.element == true{
                self.returnLastDBInfo()
            }
        }.disposed(by: disposeBag)
    }
    
    func returnLastDBInfo(){
        if !userInfoDB.isEmpty{
            if Connectivity.isConnectedToInternet{
                let lastInfo = userInfoDB.last!
                for i in lastInfo.logins{
                   self.userNameLabel.text = i.login
                }
                for i in lastInfo.names{
                    self.nameLabel.text = "Name: \(i.name)"
                }
                for i in lastInfo.avaURLs{
                    AvatarLoader().uploadAvatarsAndSaveInfo(ava_url: i.avaURL, cellImage: self.userIcon)
                }
                for i in lastInfo.emails{
                    self.emailLabel.text = "Email: \(i.email)"
                }
                for i in lastInfo.locations{
                    self.locationLabel.text = "Location: \(i.location)"
                }
                for i in lastInfo.company{
                    self.companyLabel.text = "Company: \(i.company)"
                }
                for i in lastInfo.numsRepos{
                    self.PubReposCountLabel.text = "Public repos: \(i.numRepos)"
                }
            }else{
                Alerts().offlineAlert(vc: self)
            }
        }
    }
}

extension UserViewController: uploadUserInfo {
    func uploadRepos(repo_names: [String], repo_privates: [Bool], description: [String], create_dates: [String], update_dates: [String], push_dates: [String], lang_repo: [String]) {
        self.repo_names = repo_names
        self.repo_privates = repo_privates
        self.description_repo = description
        self.create_dates = create_dates
        self.update_dates = update_dates
        self.push_dates = push_dates
        self.lang_repo = lang_repo
        self.allReposTable.reloadData()
    }
}

extension UserViewController: UITableViewDataSource{

    func tableView(_ tableView_Alam: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repo_names.count
    }

    func tableView(_ tableView_Alam: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView_Alam.dequeueReusableCell(withIdentifier: "repoCell", for: indexPath) as! UserReposTableViewCell
        cell.repoCreateLabel.text = "Create: \(Formatter().formatteDate(date: create_dates[indexPath.row]))"
        cell.repoDescriptLabel.text = self.description_repo[indexPath.row]
        cell.repoLangLabel.text = lang_repo[indexPath.row]
        cell.repoNameLabel.text = repo_names[indexPath.row]
        cell.repoUpdateLabel.text = "Last update: \(Formatter().formatteDate(date:update_dates[indexPath.row]))"
        cell.repoPushLabel.text = "Push: \(Formatter().formatteDate(date:push_dates[indexPath.row]))"
        cell.repoStatusLabel.text = "Private: \(Formatter().formattePrivate(status: repo_privates[indexPath.row]))"
        return cell
    }
}
