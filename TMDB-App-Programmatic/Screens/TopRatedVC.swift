//
//  TopRatedVC.swift
//  TMDB-App-Programmatic
//
//  Created by Eden Chen on 05/12/2022.
//

import UIKit

class TopRatedVC: TMDBDataLoadingVC {

    let tableView = UITableView()
    let path = "https://api.themoviedb.org/3/movie/top_rated?&language=en-US"
    var movies: [MovieModel] = []
    var page = 1
    var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        getMovies(page: page)
    }
    
    
    func getMovies(page: Int) {
        isLoading = true
        showLoadingView()
        NetworkManager.shared.getMovies(with: path, page: page) { [weak self] result in
            guard let self = self else { return }
            switch result {
                case .success(let movies):
                    self.movies.append(contentsOf: movies)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
            self.dismissLoadingView()
        }
        isLoading = false
    }
    
    
    func configureTableView() {
        tableView.configureTableView(with: view)
        tableView.delegate = self
        tableView.dataSource = self
    }

}


extension TopRatedVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
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
                getMovies(page: page)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}
