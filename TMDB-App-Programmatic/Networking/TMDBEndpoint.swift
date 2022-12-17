//
//  TMDBEndpoint.swift
//  TMDB-App-Programmatic
//
//  Created by Eden Chen on 16/12/2022.
//

import Foundation

//MARK: - TMDB Endpoint

enum TMDBEndpoint: Endpoint {
    case getNowPlayingMovies(page: Int)
    case getTopRatedMovies(page: Int)
    case getSearchResult(page: Int, query: String)
    
    var scheme: String {
        switch self {
            default:
                return "https"
        }
    }
    
    var baseURL: String {
        switch self {
            default:
                return "api.themoviedb.org"
        }
    }
    
    
    var path: String {
        switch self {
            case .getNowPlayingMovies:
                return "/3/movie/now_playing"
            case .getTopRatedMovies:
                return "/3/movie/top_rated"
            case .getSearchResult:
                return "/3/search/movie"
        }
    }
    
    var parameters: [URLQueryItem] {
        //Disclaimer: for simplicity's sake
        let apiKey = "5269d9698555638ca4df84d6fa04c4ad"
        
        switch self {
                
            case .getNowPlayingMovies(let page), .getTopRatedMovies(let page):
                return [URLQueryItem(name: "api_key", value: apiKey),
                        URLQueryItem(name: "page", value: String(page))]
            case .getSearchResult(let page, let query):
                return [
                    URLQueryItem(name: "query", value: query),
                    URLQueryItem(name: "api_key", value: apiKey),
                    URLQueryItem(name: "page", value: String(page))
                ]
        }
    }
    
    var method: String {
        switch self {
            case .getNowPlayingMovies:
                return "GET"
            case .getTopRatedMovies:
                return "GET"
            case .getSearchResult:
                return "GET"
        }
    }
    
    
}
