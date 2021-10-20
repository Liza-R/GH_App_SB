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
    
    private let allSavedViewedUsersInfoDB = ReturnUserInfoModels().returnAllUserInfo(),
                userVM = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.returnLastDBInfo()
        self.allReposTable.rowHeight = 160
        self.allReposTable.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Connectivity.isConnectedToInternet{
            userVM.uploadUserInfo()
            userVM.uploadReposInfo()
            savingUserInfo.asObservable().subscribe{ status in
                if status.element == true{
                    self.returnLastDBInfo()
                }
            }.disposed(by: disposeBag)
        }else{
            Alerts().offlineAlert(vc: self)
        }
    }
    
    func returnLastDBInfo(){
        if !allSavedViewedUsersInfoDB.isEmpty{
            print("DB is not empty")
            for i in allSavedViewedUsersInfoDB{
                for t in i.user{
                    if t.login == chooseLogin{
                        self.nameLabel.text = "Name: \(t.name)"
                        self.userNameLabel.text = t.login
                        self.userIcon.image = UIImage(data: t.ava as Data)
                        self.emailLabel.text = "Email: \(t.email)"
                        self.locationLabel.text = "Location: \(t.location)"
                        self.companyLabel.text = "Company: \(t.company)"
                        self.PubReposCountLabel.text = "Public repos: \(t.numRepos)"
                        for h in i.repos_user{
                            self.repo_names.append(h.repo_name)
                            self.repo_privates.append(h.repo_private)
                            self.description_repo.append(h.description_repo)
                            self.create_dates.append(h.create_date)
                            self.update_dates.append(h.update_date)
                            self.push_dates.append(h.push_date)
                            self.lang_repo.append(h.lang_repo)
                        }
                        self.allReposTable.reloadData()
                    }
                }
            }
        }else{
            print("DB is empty")
        }
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
