//
//  TMDBTabBarVC.swift
//  TMDB-App-Programmatic
//
//  Created by Eden Chen on 05/12/2022.
//

import UIKit

class TMDBTabBarVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = [createNowPlayingNC(), createTopRatedNC(), createSearchNC()]
        UITabBar.appearance().tintColor = .systemMint
        
    }
    
    
    func createNowPlayingNC() -> UINavigationController {
        let nowPlayingVC = NowPlayingVC()
        nowPlayingVC.title = "Now Playing"
        nowPlayingVC.tabBarItem = UITabBarItem(title: "Now Playing", image: UIImage(systemName: "play.rectangle"), tag: 0)
        
        return UINavigationController(rootViewController: nowPlayingVC)
    }

    
    func createTopRatedNC() -> UINavigationController {
        let topRatedVC = TopRatedVC()
        topRatedVC.title = "Top Rated"
        topRatedVC.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 1)
        
        return UINavigationController(rootViewController: topRatedVC)
    }
    
    
    func createSearchNC() -> UINavigationController {
        let searchVC = SearchVC()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 2)
        
        return UINavigationController(rootViewController: searchVC)
    }
}
