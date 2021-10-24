//
//  ExtensionForAlerts.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 24/10/2021.
//

import Foundation
import UIKit

extension UIAlertController {
    func pruneNegativeWidthConstraints() {
        for subView in self.view.subviews {
            for constraint in subView.constraints where constraint.debugDescription.contains("width == - 16") {
                subView.removeConstraint(constraint)
            }
        }
    }
}
