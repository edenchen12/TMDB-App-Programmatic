//
//  TMDBDataLoadingVC.swift
//  TMDB-App-Programmatic
//
//  Created by Eden Chen on 05/12/2022.
//

import UIKit

class TMDBDataLoadingVC: UIViewController {

    var containerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor   = .systemBackground
        containerView.alpha             = 0
        
        UIView.animate(withDuration: 0.15) { self.containerView.alpha = 0.8 }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }
    
    
    func showEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView = TMDBEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        emptyStateView.tag = 10
        view.addSubview(emptyStateView)
    }
    
    
    func dismissEmptyStateView() {
        DispatchQueue.main.async {
            self.view.viewWithTag(10)?.removeFromSuperview()
        }
    }
}
