//
//  TMDBDataLoadingVC.swift
//  TMDB-App-Programmatic
//
//  Created by Eden Chen on 05/12/2022.
//

import UIKit

class TMDBDataLoadingVC: UIViewController {

    var containerView: UIView!
    var emptyStateView = TMDBEmptyStateView()
    
    var movies = [MovieModel]()
    var page = 1
    var isLoading = true
    var hasMorePages = true

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    func getMoviesGeneric(endpoint: TMDBEndpoint, tableView: UITableView){
        isLoading = true
        showLoadingView()
        NetworkEngine.load(endpoint: endpoint) { (result: Result<MoviesModel, TMDBError>) in
            switch result {
                case .success(let response):
                    if response.results.isEmpty && self.movies.isEmpty {
                        self.presentGFAlertOnMainThread(title: "Something Went Wrong ", message: "couldn't find the movie you looking for, Please check your spelling or try anther movie", buttonTitle: "Ok")
                        break
                    }
                    
                    if self.page <= response.totalPages {
                        self.hasMorePages = true
                        self.movies.append(contentsOf: response.results)
                        DispatchQueue.main.async {
                            tableView.reloadData()
                        }
                    } else {
                        self.hasMorePages = false
                        self.presentGFAlertOnMainThread(title: "End Of The List", message: "it's appear you got to the bottom of the list", buttonTitle: "Ok")
                    }
                case .failure(let error):
                    self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                    return
            }
            self.dismissLoadingView()
        }
        isLoading = false
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
        emptyStateView = TMDBEmptyStateView(message: message)

        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
    
    
    func dismissEmptyStateView() {
        DispatchQueue.main.async {
            self.emptyStateView.removeFromSuperview()
        }
    }
}
