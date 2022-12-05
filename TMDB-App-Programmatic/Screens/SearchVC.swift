//
//  SearchVC.swift
//  TMDB-App-Programmatic
//
//  Created by Eden Chen on 05/12/2022.
//

import UIKit

class SearchVC: TMDBDataLoadingVC  {
    
    let tableView = UITableView()
    var searchedMovies = [MovieModel]()
    var isLoading = false
    var page = 1
    let path = "https://api.themoviedb.org/3/search/movie?query="
    let emptyViewMessage = "Please search for a movie."
    var currentQuery = ""
    let searchController = UISearchController()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureSearchController()
        updateUI()
    }
    
    
    func getMovies(withQuery query: String) {
        print(page)
        showLoadingView()
        isLoading = true
        NetworkManager.shared.getMovies(with: path + query, page: page) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                case .success(let movies):
                    if movies.isEmpty {
                        DispatchQueue.main.async {
                            self.searchController.searchBar.text = ""
                            self.presentGFAlert(title: "Something went wrong", message: "There are no movies that matched your query.", buttonTitle: "Ok")
                        }
                        break
                    }
                    
                    self.searchedMovies.append(contentsOf: movies)
                    self.updateUI()
                    self.page += 1
                    
                case .failure(let error):
                    self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                    print(error.localizedDescription)
            }
        }
        dismissLoadingView()
        isLoading = false
    }
    
    
    func configureTableView() {
        tableView.configureTableView(with: view)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    func configureSearchController() {
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search a movie"
        navigationItem.searchController = searchController
    }
    
    
    func updateUI() {
        if searchedMovies.isEmpty {
            DispatchQueue.main.async {
                self.currentQuery = ""
                self.showEmptyStateView(with: self.emptyViewMessage, in: self.view)
                return
            }
        } else {
            dismissEmptyStateView()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}


extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedMovies.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.reuseID) as! MovieCell
        let movie = searchedMovies[indexPath.row]
        cell.set(movie: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let movie = searchedMovies[indexPath.row]
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
                getMovies(withQuery: currentQuery)
                DispatchQueue.main.async { self.tableView.reloadData() }
            } else {
                presentGFAlertOnMainThread(title: "Loading more movies", message: "Please wait until we finish to load the next movies", buttonTitle: "Ok")
            }
        }
    }
    
}


extension SearchVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let filter = searchBar.text, !filter.isEmpty else { return }
        searchedMovies.removeAll()
        let query = filter.replacingOccurrences(of: " " , with: "%20").lowercased()
        currentQuery = query
        getMovies(withQuery: currentQuery)
        resignFirstResponder()
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchedMovies.removeAll()
        currentQuery = ""
        page = 1
        DispatchQueue.main.async {
            self.showEmptyStateView(with: self.emptyViewMessage, in: self.view)
            self.tableView.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            currentQuery = ""
            page = 1
            searchedMovies.removeAll()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}

