//
//  DetailsVC.swift
//  TMDB-App-Programmatic
//
//  Created by Eden Chen on 05/12/2022.
//

import UIKit

class DetailsVC: UIViewController {
    
        
    let posterImage = TMDBImageView(frame: .zero)
    let titleLabel = TMDBTitleLabel(textAlignment: .center, fontSize: 28)
    let overviewLabel = TMDBBodyLabel(textAlignment: .left)

    var posterURL: String?
    var movieTitle: String?
    var overview: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureUI()
        configureView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    
    func configureUI() {
        view.addSubview(posterImage)
        view.addSubview(titleLabel)
        view.addSubview(overviewLabel)
        
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 8

        NSLayoutConstraint.activate([
            posterImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            posterImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            posterImage.heightAnchor.constraint(equalToConstant: 320),
            posterImage.widthAnchor.constraint(equalToConstant: 320),
            
            titleLabel.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            overviewLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            overviewLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            overviewLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: padding)
            
        ])
        
    }
    
    
    func configureView() {
        configureImageView()
        configureTitleLabel()
        configureOverviewLabel()
    }
    
    
    func configureImageView() {
        guard let posterURL = posterURL else {
            posterImage.image = Images.placeholder
            return
        }
        posterImage.downloadImage(from: posterURL)
    }
    
    
    func configureTitleLabel() {
        guard let movieTitle = movieTitle else { return }
        titleLabel.text = movieTitle
        titleLabel.numberOfLines = 2
        titleLabel.lineBreakMode = .byTruncatingTail
    }

    
    func configureOverviewLabel() {
        guard let overview = overview else { return }
        if overview == "" {
            overviewLabel.text = "No overview available"
            overviewLabel.textAlignment = .center
        } else {
            overviewLabel.text = overview
        }
        
        overviewLabel.numberOfLines = 0
    }
}

