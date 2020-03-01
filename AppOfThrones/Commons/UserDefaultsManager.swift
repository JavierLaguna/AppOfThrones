//
//  UserDefaultsManager.swift
//  AppOfThrones
//
//  Created by Javier Laguna on 01/03/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import Foundation

final class UserDefaultsManager {
    
    // MARK: Public Functions - Save
    
    static func saveFavorites(_ favorites: [Int]) {
        UserDefaults.standard.set(favorites, forKey: Constants.UserDefaultKey.favorites)
    }
    
    static func saveRates(_ rates: [Rating]) {
        guard let data = try? JSONEncoder().encode(rates) else { return }
        
        self.saveData(data, forKey: Constants.UserDefaultKey.rates)
    }
    
    // MARK: Public Functions - Get
    
    static func getFavorites() -> [Int] {
        return UserDefaults.standard.array(forKey: Constants.UserDefaultKey.favorites) as? [Int] ?? [Int]()
    }
    
    static func getRates() -> [Rating] {
        let decoder = JSONDecoder()
        
        guard let data = getData(forKey: Constants.UserDefaultKey.rates),
            let rates = try? decoder.decode([Rating].self, from: data) else {
            return [Rating]()
        }
        
        return rates
    }
    
    // MARK: Private functions
    
    static private func saveData(_ data: Data, forKey: String) {
        UserDefaults.standard.set(data, forKey: forKey)
    }
    
    static private func getData(forKey: String) -> Data? {
        return UserDefaults.standard.data(forKey: forKey)
    }
}
