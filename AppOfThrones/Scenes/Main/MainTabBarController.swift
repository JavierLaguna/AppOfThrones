//
//  MainTabBarController.swift
//  AppOfThrones
//
//  Created by Javier Laguna on 24/02/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        addTabs()
    }
     
    // MARK: Private functions
    
    private func configureView() {

        UINavigationBar.appearance().overrideUserInterfaceStyle = .dark
        UINavigationBar.appearance().tintColor = .orangeMain
        
        tabBar.barStyle = .black
        tabBar.tintColor = .orangeMain
    }
    
    private func addTabs() {
        let episodesVC = EpisodesViewController()
        let castVC = CastViewController()
        let houseVC = HouseViewController()
        let favorites = FavoritesViewController()
        let settingsVC = SettingsViewController()
        
        episodesVC.tabBarItem = UITabBarItem(title: "Seasons", image: UIImage(systemName: "film.fill"), tag: 0)
        castVC.tabBarItem = UITabBarItem(title: "Cast", image: UIImage(systemName: "person.3.fill"), tag: 1)
        houseVC.tabBarItem = UITabBarItem(title: "Houses", image: UIImage(systemName: "shield.lefthalf.fill"), tag: 2)
        favorites.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart.fill"), tag: 3)
        settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 4)
        
        let navBarEpisodesVC = UINavigationController(rootViewController: episodesVC)
        let navBarCastVC = UINavigationController(rootViewController: castVC)
        let navBarHouseVC = UINavigationController(rootViewController: houseVC)
        let navBarFavoritesVC = UINavigationController(rootViewController: favorites)
        let navBarSettingsVC = UINavigationController(rootViewController: settingsVC)
        
        self.viewControllers = [
            navBarEpisodesVC,
            navBarCastVC,
            navBarHouseVC,
            navBarFavoritesVC,
            navBarSettingsVC
        ]
    }
}
