//
//  SceneDelegate.swift
//  AppOfThrones
//
//  Created by Javier Laguna on 11/02/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }
        
        let episodesVC = EpisodesViewController()
        let castVC = CastViewController()
        let houseVC = HouseViewController()
        let settingsVC = SettingsViewController()
        
        episodesVC.tabBarItem = UITabBarItem(title: "Seasons", image: UIImage(systemName: "film.fill"), tag: 0)
        castVC.tabBarItem = UITabBarItem(title: "Cast", image: UIImage(systemName: "person.3.fill"), tag: 1)
        houseVC.tabBarItem = UITabBarItem(title: "Houses", image: UIImage(systemName: "shield.lefthalf.fill"), tag: 2)
        settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 3)
        
        UINavigationBar.appearance().overrideUserInterfaceStyle = .dark
        UINavigationBar.appearance().tintColor = UIColor(red: 235/255, green: 172/255, blue: 38/255, alpha: 1)
        
        let navBarEpisodesVC = UINavigationController(rootViewController: episodesVC)
        let navBarCastVC = UINavigationController(rootViewController: castVC)
        let navBarHouseVC = UINavigationController(rootViewController: houseVC)
        let navBarSettingsVC = UINavigationController(rootViewController: settingsVC)
        
        let tabBarVC = UITabBarController()
        tabBarVC.viewControllers = [navBarEpisodesVC, navBarCastVC, navBarHouseVC, navBarSettingsVC]
        tabBarVC.tabBar.barStyle = .black
        tabBarVC.tabBar.tintColor = .orangeMain
        
        window = UIWindow.init(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = tabBarVC
        window?.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}
