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
    let emptyViewMessage = "Please search for a movie."
    var currentQuery = ""
    var isSearching = false
    let searchController = UISearchController()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureSearchController()
        updateUI()
    }
    
    //    singleton networkManager here for references
    //    func getMovies(withQuery query: String) {
    //        print(page)
    //        showLoadingView()
    //        isLoading = true
    //        NetworkManager.shared.getMovies(with: path + query, page: page) { [weak self] result in
    //            guard let self = self else { return }
    //
    //            switch result {
    //                case .success(let movies):
    //                    if movies.isEmpty {
    //                        DispatchQueue.main.async {
    //                            self.searchController.searchBar.text = ""
    //                            self.presentGFAlert(title: "Something went wrong", message: "There are no movies that matched your query.", buttonTitle: "Ok")
    //                        }
    //                        break
    //                    }
    //
    //                    self.searchedMovies.append(contentsOf: movies)
    //                    self.updateUI()
    //                    self.page += 1
    //
    //                case .failure(let error):
    //                    self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
    //                    print(error.localizedDescription)
    //            }
    //        }
    //        dismissLoadingView()
    //        isLoading = false
    //    }
    //
    
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
        if !isSearching {
            hasMorePages = true
            movies.removeAll()
            page = 1
            currentQuery = ""
            showEmptyStateView(with: self.emptyViewMessage, in: self.view)
            DispatchQueue.main.async {
                self.tableView.reloadData()
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
            page += 1
            if !isLoading  {
                getMoviesGeneric(endpoint: .getSearchResult(page: page, query: currentQuery), tableView: tableView)
                DispatchQueue.main.async { self.tableView.reloadData() }
            } else {
                presentGFAlertOnMainThread(title: "Loading more movies", message: "Please wait until we finish to load the next movies", buttonTitle: "Ok")
            }
        }
    }
    
}


extension SearchVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isSearching = true
        guard let filter = searchBar.text, !filter.isEmpty else { return }
        movies.removeAll()
        let query = filter.lowercased()
        currentQuery = query
        //        getMovies(withQuery: currentQuery)
        print(currentQuery)
        print(page)
        updateUI()
        getMoviesGeneric(endpoint: .getSearchResult(page: page, query: currentQuery), tableView: tableView)
        resignFirstResponder()
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateUI()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearching = false
            updateUI()
        }
    }
    
}

