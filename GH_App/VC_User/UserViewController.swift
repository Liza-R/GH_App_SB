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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let viewModel = UserViewModel()
        viewModel.infoUserDelegate = self
    }
}
extension UserViewController: uploadUserInfo {
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
