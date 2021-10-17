//
//  ExtensionForURLs.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 17/10/2021.
//

import Foundation

extension String{
    var encodeUrl: String{
        return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
    var decodeUrl: String{
        return self.removingPercentEncoding!
    }
}
