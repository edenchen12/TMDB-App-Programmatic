//
//  UIViewController+Ext.swift
//  TMDB-App-Programmatic
//
//  Created by Eden Chen on 05/12/2022.
//

import UIKit

extension UIViewController {
    
    func presentGFAlert(title: String, message: String, buttonTitle: String) {
        let alertVC = TMDBAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            present(alertVC, animated: true)
        
    }
    
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
            DispatchQueue.main.async {
                let alertVC = TMDBAlertVC(title: title, message: message, buttonTitle: buttonTitle)
                alertVC.modalPresentationStyle = .overFullScreen
                alertVC.modalTransitionStyle = .crossDissolve
                self.present(alertVC, animated: true)
            }
        }
    
}
