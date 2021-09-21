//
//  RepoObj.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 21/09/2021.
//

import Foundation
import RealmSwift

class NameForRepoClass: Object {
    @objc dynamic var name = ""
}
class PrivateForRepoClass: Object {
    @objc dynamic var `private` = ""
}
class DescriptForRepoClass: Object {
    @objc dynamic var descript = ""
}
class LangForRepoClass: Object {
    @objc dynamic var lang_url = ""
}

class CreateDateForRepoClass: Object {
    @objc dynamic var create_date = ""
}

class UpdateDateForRepoClass: Object {
    @objc dynamic var update_date = ""
}

class PushDateForRepoClass: Object {
    @objc dynamic var push_date = ""
}

class ReposInfoDB: Object{
    let names = List<NameForRepoClass>(),
        privates = List<PrivateForRepoClass>(),
        descripts = List<DescriptForRepoClass>(),
        langs = List<LangForRepoClass>(),
        create_dates = List<CreateDateForRepoClass>(),
        update_dates = List<UpdateDateForRepoClass>(),
        push_dates = List<PushDateForRepoClass>()
}

