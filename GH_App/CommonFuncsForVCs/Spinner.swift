//
//  Spinner.swift
//  GH_App
//
//  Created by Elizaveta Rogozhina on 24/10/2021.
//

import Foundation
import UIKit

class Spinner{
    private let spinner = UIActivityIndicatorView()
    
    func createSpinner(vc: UIView){
        spinner.style = .large
        spinner.color = .white
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        vc.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: vc.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: vc.centerYAnchor).isActive = true
    }
    func stopSpinner(){
        spinner.stopAnimating()
    }
}
