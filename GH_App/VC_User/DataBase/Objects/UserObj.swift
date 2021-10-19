//
//  UserObj.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 19/10/2021.
//

import Foundation
import RealmSwift

class LoginUserClass: Object {
    @objc dynamic var login = ""
}
class NameUserClass: Object {
    @objc dynamic var name = ""
}
class CompanyUserClass: Object {
    @objc dynamic var company = ""
}
class LocationUserClass: Object {
    @objc dynamic var location = ""
}
class NumPubReposUserClass: Object {
    @objc dynamic var numRepos = 0
}
class EmailUserClass: Object {
    @objc dynamic var email = ""
}
class ReposURLUserClass: Object {
    @objc dynamic var reposURL = ""
}
class AvatarURLUserClass: Object {
    @objc dynamic var avaURL = ""
}

class ViewedUsersDB: Object{
    let logins = List<LoginUserClass>(),
        names = List<NameUserClass>(),
        company = List<CompanyUserClass>(),
        locations = List<LocationUserClass>(),
        numsRepos = List<NumPubReposUserClass>(),
        emails = List<EmailUserClass>(),
        reposURLS = List<ReposURLUserClass>(),
        avaURLs = List<AvatarURLUserClass>()
}
