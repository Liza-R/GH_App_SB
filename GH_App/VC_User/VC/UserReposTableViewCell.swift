//
//  UserReposTableViewCell.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 21/09/2021.
//

import UIKit

class UserReposTableViewCell: UITableViewCell {

    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var repoStatusLabel: UILabel!
    @IBOutlet weak var repoDescriptLabel: UILabel!
    @IBOutlet weak var repoLangLabel: UILabel!

    @IBOutlet weak var repoCreateLabel: UILabel!
    @IBOutlet weak var repoUpdateLabel: UILabel!
    @IBOutlet weak var repoPushLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
