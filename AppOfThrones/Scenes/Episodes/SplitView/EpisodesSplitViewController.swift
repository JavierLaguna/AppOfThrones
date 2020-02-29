//
//  EpisodesSplitViewController.swift
//  AppOfThrones
//
//  Created by Javier Laguna on 29/02/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

final class EpisodesSplitViewController: UISplitViewController, TabBarItemable {
    
    // MARK: Variables
    
    var tbTitle: String { "Seasons" }
    var tbImage: UIImage? { UIImage(systemName: "film.fill") }
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setControllers()
        configureView()
    }
    
    // MARK: Private functions
    
    private func setControllers() {
        let rootVC = EpisodesViewController()
        rootVC.setTitle(tbTitle)

        viewControllers = [
            UINavigationController(rootViewController: rootVC),
            PlaceholderViewController()
        ]
    }
    
    private func configureView() {
        preferredDisplayMode = .primaryOverlay
        preferredDisplayMode = .allVisible
        
        delegate = self
    }
}

// MARK: UISplitViewControllerDelegate

extension EpisodesSplitViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}
