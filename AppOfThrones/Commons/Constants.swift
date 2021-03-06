//
//  Constants.swift
//  AppOfThrones
//
//  Created by Javier Laguna on 24/02/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

struct Constants {
    struct Episodes {
        static let numberOfSeasons = 8
    }
    
    struct NotificationCenter {
        static let favoritesChanged = Notification.Name("NCFavoritesChanged")
        static let ratesChanged = Notification.Name("NCRatesChanged")
    }
    
    struct UserDefaultKey {
        static let favorites = "UDFavorites"
        static let rates = "UDRates"
    }
}
