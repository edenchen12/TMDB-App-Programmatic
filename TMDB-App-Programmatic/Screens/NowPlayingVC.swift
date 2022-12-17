//
//  NowPlayingVC.swift
//  TMDB-App-Programmatic
//
//  Created by Eden Chen on 05/12/2022.
//

import UIKit

class NowPlayingVC: TMDBDataLoadingVC {

    let tableView = UITableView()
            
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        getMoviesGeneric(endpoint: .getNowPlayingMovies(page: page), tableView: tableView)
    }
    
    //MARK: - NetworkManager caller (old way here for reference)
//
//    func getMovies(page: Int) {
//        isLoading = true
//        showLoadingView()
//        NetworkManager.shared.getMovies(with: path, page: page) { result in
//            switch result {
//                case .success(let movies):
//                    self.movies.append(contentsOf: movies)
//                    DispatchQueue.main.async {
//                        self.tableView.reloadData()
//                    }
//                case .failure(let error):
//                    self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
//                    return
//            }
//            self.dismissLoadingView()
//        }
//        isLoading = false
//    }
    
    


    func configureTableView() {
        tableView.configureTableView(with: view)
        tableView.delegate = self
        tableView.dataSource = self
    }
}


//MARK: - Table View Delegate and DataSource

extension NowPlayingVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.reuseID) as! MovieCell
        let movie = movies[indexPath.row]
        cell.set(movie: movie)
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let movie = movies[indexPath.row]
        let destVC = DetailsVC()
        destVC.posterURL = movie.posterPath
        destVC.movieTitle = movie.title
        destVC.overview = movie.overview
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            if !isLoading  {
                page += 1
                getMoviesGeneric(endpoint: .getNowPlayingMovies(page: page), tableView: tableView)
                DispatchQueue.main.async { self.tableView.reloadData() }
            } else {
                presentGFAlertOnMainThread(title: "Loading more movies", message: "Please wait until we finish to load the next movies", buttonTitle: "Ok")
            }
        }
    }
    
    
}
