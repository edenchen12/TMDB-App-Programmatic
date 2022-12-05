//
//  TMDBButton.swift
//  TMDB-App-Programmatic
//
//  Created by Eden Chen on 05/12/2022.
//

import UIKit

class TMDBButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(color: UIColor, title: String) {
        self.init(frame: .zero)
        set(color: color, title: title)
    }
    
    
    private func configure() {
        configuration = .filled()
        configuration?.cornerStyle = .medium
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func set(color: UIColor, title: String) {
        configuration?.baseBackgroundColor = color
        configuration?.baseForegroundColor = .white
        configuration?.title = title
    }
}
