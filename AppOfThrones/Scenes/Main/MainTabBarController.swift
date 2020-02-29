//
//  MainTabBarController.swift
//  AppOfThrones
//
//  Created by Javier Laguna on 24/02/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    // MARK: MainTabBarItem
    
    private struct MainTabBarItem {
        let viewController: UIViewController
        let displayMode: MainTabBarItemDisplayMode
        
        enum MainTabBarItemDisplayMode {
            case navController
            case splitView
        }
    }
    
    // MARK: Constants
    
    private let tabBarViewControllers: [MainTabBarItem] = [
        MainTabBarItem(viewController: EpisodesSplitViewController(tbTag: 0), displayMode: .splitView),
        MainTabBarItem(viewController: CastViewController(tbTag: 1), displayMode: .navController),
        MainTabBarItem(viewController: HouseViewController(tbTag: 2), displayMode: .navController),
        MainTabBarItem(viewController: FavoritesViewController(tbTag: 3), displayMode: .navController),
        MainTabBarItem(viewController: SettingsViewController(tbTag: 4), displayMode: .navController)
    ]
    
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
        
        self.viewControllers = tabBarViewControllers.map({
            if $0.displayMode == .navController {
                return UINavigationController(rootViewController: $0.viewController)
            }
            
            return $0.viewController
        })
    }
}
