//
//  TabBarItemable.swift
//  AppOfThrones
//
//  Created by Javier Laguna on 28/02/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import Foundation
import UIKit

protocol TabBarItemable: UIViewController {
    var tbTitle: String { get }
    var tbImage: UIImage? { get }
    
    init(tbTag: Int)
}

extension TabBarItemable where Self: UIViewController {
    init(tbTag: Int) {
        self.init()
        
        title = tbTitle
        tabBarItem = UITabBarItem(title: tbTitle, image: tbImage, tag: tbTag)
    }
}
