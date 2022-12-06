//
//  UITableView+Ext.swift
//  TMDB-App-Programmatic
//
//  Created by Eden Chen on 06/12/2022.
//

import UIKit

extension UITableView {
    
    func configureTableView(with view: UIView) {
        view.addSubview(self)
        frame         = view.bounds
        rowHeight     = 80
        register(MovieCell.self, forCellReuseIdentifier: MovieCell.reuseID)
    }
    
}
