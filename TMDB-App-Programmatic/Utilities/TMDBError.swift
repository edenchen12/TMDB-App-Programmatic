//
//  TMDBError.swift
//  TMDB-App-Programmatic
//
//  Created by Eden Chen on 05/12/2022.
//

import Foundation

enum TMDBError: String, Error {
    case invalidURL         = "This URL created an invalid request. please try again."
    case unableToComplete   = "Unable to complete your request. Please check your internet connection."
    case invalidResponse    = "Invalid response from the server. Please try again."
    case invalidData        = "The data received from the server was invalid. Please try again."
    case noMoreMovies       = "Unable to complete your request. You got to the end of the list "
}
