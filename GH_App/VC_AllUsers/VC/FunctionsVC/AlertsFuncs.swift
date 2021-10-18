//
//  AllUsersSearchAlerts.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 21/09/2021.
//

import Foundation
import UIKit

class Alerts{
    func offlineAlert(vc: UIViewController){
        let alert = UIAlertController(title: "Not Connection", message: "Please check your connection and connect the internet", preferredStyle: UIAlertController.Style.actionSheet),
        cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
         alert.addAction(cancelAction)
         alert.pruneNegativeWidthConstraints()
         vc.present(alert, animated: true, completion: nil)
    }
}
extension UIAlertController {
    func pruneNegativeWidthConstraints() {
        for subView in self.view.subviews {
            for constraint in subView.constraints where constraint.debugDescription.contains("width == - 16") {
                subView.removeConstraint(constraint)
            }
        }
    }
}
