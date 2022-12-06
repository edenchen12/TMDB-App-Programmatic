//
//  NetworkManager.swift
//  TMDB-App-Programmatic
//
//  Created by Eden Chen on 05/12/2022.
//

import UIKit

class NetworkManager {
    
    private let apiKey = "5269d9698555638ca4df84d6fa04c4ad"
    private let cache = NSCache<NSString,UIImage>()
    private var haveMorePages = true

    static let shared = NetworkManager()
    
    func getMovies(with path: String, page: Int, completed: @escaping (Result<[MovieModel], TMDBError>) -> Void) {

        if page != 1 {
            if !haveMorePages {
                completed(.failure(.noMoreMovies))
                return
            }
        }
        
        let urlString = path + "&page=\(page)&api_key=\(apiKey)&language=en-US"
        print(urlString)
        guard let url = URL(string: urlString) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let movies = try decoder.decode(MoviesModel.self, from: data)
              
                if movies.results.isEmpty {
                    completed(.success(movies.results))
                }
                
                    if page <= movies.totalPages {
                        self.haveMorePages = true
                        print("movies total pages: \(movies.totalPages)")
                        print("movies count \(movies.results.count)")
                        completed(.success(movies.results))
                    } else {
                        self.haveMorePages = false
                    }
                
            } catch {
                completed(.failure(.unableToComplete))
            }
        }
        task.resume()
    }
    
    
    func downloadImage(with poster: String, completed: @escaping (UIImage?) -> Void) {
         let stringURL = "https://image.tmdb.org/t/p/w154\(poster)"
        let cacheKey = NSString(string: stringURL)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: stringURL) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            
            if let _ = error {
                completed(nil)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil)
                return
            }
            
            guard let data = data else {
                completed(nil)
                return
            }
            guard let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        
        task.resume()
        
    }
}
