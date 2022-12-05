//
//  MoviesModel.swift
//  TMDB-App-Programmatic
//
//  Created by Eden Chen on 05/12/2022.
//

import Foundation

struct MoviesModel: Codable {
    let page: Int
    let results: [MovieModel]
    let totalPages: Int
}


struct MovieModel: Codable {
    let id: Int?
    let title: String?
    var posterPath: String?
    let overview: String?
    let releaseDate: String?
}
