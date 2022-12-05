//
//  TMDBImageView.swift
//  TMDB-App-Programmatic
//
//  Created by Eden Chen on 05/12/2022.
//

import UIKit

class TMDBImageView: UIImageView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        contentMode = .scaleAspectFit
        layer.cornerRadius = 10
        clipsToBounds = true
        tintColor = .lightGray
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func downloadImage(from url: String?) {
        guard let url = url else {
            DispatchQueue.main.async { self.image = Images.cellPlaceholder }
            return
        }
        
        NetworkManager.shared.downloadImage(with: url) { [weak self] image in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.image = image
                
            }
        }
    }
}
