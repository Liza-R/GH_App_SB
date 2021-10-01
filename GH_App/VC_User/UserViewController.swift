//
//  UserViewController.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 21/09/2021.
//

import UIKit

class UserViewController: UIViewController {
    @IBOutlet weak var userIcon: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var PubReposCountLabel: UILabel!
    @IBOutlet weak var allReposTable: UITableView!
    
    var repo_names: [String] = [],
        repo_privates: [Bool] = [],
        description_repo: [String] = [],
        create_dates: [String] = [],
        update_dates: [String] = [],
        push_dates: [String] = [],
        lang_repo: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let viewModel = UserViewModel()
        viewModel.infoUserDelegate = self
        self.allReposTable.rowHeight = 200
        self.allReposTable.reloadData()
        self.allReposTable.dataSource = self
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
    
    func uploadUInfo(login: String, avatar_url: String, repos_url: String, name: String, company: String, location: String, public_repos_c: Int, email: String){
        AvatarLoader().newAvatarLoader(ava_url: avatar_url, myImageView: self.userIcon)
        self.userNameLabel.text = login
        self.nameLabel.text = "Name: \(name)"
        self.companyLabel.text = "Company: \(company)"
        self.locationLabel.text = "Location: \(location)"
        self.PubReposCountLabel.text = "Public repos: \(public_repos_c)"
        self.emailLabel.text = "Email: \(email)"
    }
}

extension UserViewController: UITableViewDataSource{

    func tableView(_ tableView_Alam: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repo_names.count
    }

    func tableView(_ tableView_Alam: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView_Alam.dequeueReusableCell(withIdentifier: "repoCell", for: indexPath) as! UserReposTableViewCell
        cell.repoCreateLabel.text = self.create_dates[indexPath.row]
        cell.repoDescriptLabel.text = self.description_repo[indexPath.row]
        cell.repoLangLabel.text = lang_repo[indexPath.row]
        cell.repoNameLabel.text = repo_names[indexPath.row]
        cell.repoUpdateLabel.text = update_dates[indexPath.row]
        cell.repoPushLabel.text = push_dates[indexPath.row]
        cell.repoStatusLabel.text = "Private: \(repo_privates[indexPath.row])"
        
        return cell
    }
}
