//
//  Formatter.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 01/10/2021.
//

import Foundation

class Formatter{
    func formatteDate(date: String) -> String{
        let d = date.components(separatedBy: "T"),
            newDate = d[0]
        return newDate
    }
    func formattePrivate(status: Bool) -> String{
        var newStatus = ""
        switch status{
        case true:
            newStatus = "Yes"
        default:
            newStatus = "No"
        }
        return newStatus
    }
}
