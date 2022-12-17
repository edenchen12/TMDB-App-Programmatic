//
//  TopRatedVC.swift
//  TMDB-App-Programmatic
//
//  Created by Eden Chen on 05/12/2022.
//

import UIKit

class TopRatedVC: TMDBDataLoadingVC {

    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        getMoviesGeneric(endpoint: .getTopRatedMovies(page: page), tableView: tableView)
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
                getMoviesGeneric(endpoint: .getTopRatedMovies(page: page), tableView: tableView)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}
