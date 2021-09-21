//
//  LangObj.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 21/09/2021.
//

import Foundation
import RealmSwift

class LangForLangClass: Object {
    @objc dynamic var lang = ""
}

class LangInfoDB: Object{
    let langs = List<LangForLangClass>()
}
