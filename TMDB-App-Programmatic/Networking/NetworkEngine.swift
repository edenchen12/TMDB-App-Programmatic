//
//  NetworkEngine.swift
//  TMDB-App-Programmatic
//
//  Created by Eden Chen on 16/12/2022.
//

import Foundation

class NetworkEngine {
    
    
    class func load<T: Codable>(endpoint: Endpoint, completion: @escaping (Result<T, TMDBError>) -> Void) {
        
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.host = endpoint.baseURL
        components.path = endpoint.path
        components.queryItems = endpoint.parameters
        
        guard let url = components.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        print("URL From Protocol: ", url)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            if let _ = error {
                completion(.failure(TMDBError.unableToComplete))
                print(error?.localizedDescription ?? "Unknown error")
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(TMDBError.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(TMDBError.invalidData))
                return
            }
            
            DispatchQueue.main.async {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let responseObject = try decoder.decode(T.self, from: data)
                    completion(.success(responseObject))
                } catch {
                    completion(.failure(TMDBError.unableToComplete))
                }
            }
        }
        task.resume()
    }
}

