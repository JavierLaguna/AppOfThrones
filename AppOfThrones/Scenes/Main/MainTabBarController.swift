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
        
        let tabBarViewControllers = [ // TabBarItemable
            EpisodesViewController(tbTag: 0),
            CastViewController(tbTag: 1),
            HouseViewController(tbTag: 2),
            FavoritesViewController(tbTag: 3),
            SettingsViewController(tbTag: 4)
        ]
        
        self.viewControllers = tabBarViewControllers.map({ UINavigationController(rootViewController: $0) })
    }
}
