//
//  MovieCell.swift
//  TMDB-App-Programmatic
//
//  Created by Eden Chen on 05/12/2022.
//

import UIKit

class MovieCell: UITableViewCell {

    static let reuseID = "MovieCell"
    let movieImage = TMDBImageView(frame: .zero)
    let movieLabel = TMDBTitleLabel(textAlignment: .left, fontSize: 16)

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(movie: MovieModel) {
        movieImage.downloadImage(from: movie.posterPath)
        movieLabel.text = movie.title
    }
    
    
    private func configure() {
        addSubview(movieImage)
        addSubview(movieLabel)
        accessoryType = .disclosureIndicator
        selectionStyle = .none
        
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            movieImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            movieImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            movieImage.heightAnchor.constraint(equalToConstant: 60),
            movieImage.widthAnchor.constraint(equalToConstant: 60),
            
            movieLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            movieLabel.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 8),
            movieLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            movieLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
    
}
