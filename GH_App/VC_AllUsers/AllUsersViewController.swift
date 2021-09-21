//
//  ViewController.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 21/09/2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var userSearchBar: UISearchBar!
    @IBOutlet weak var allUsersTable: UITableView!
    
    var usersLogins: [String] = [],
        usersAva: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.allUsersTable.reloadData()
        self.allUsersTable.dataSource = self
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
