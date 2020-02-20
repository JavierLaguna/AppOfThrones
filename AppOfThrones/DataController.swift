//
//  DataController.swift
//  AppOfThrones
//
//  Created by Javier Laguna on 18/02/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import Foundation

final class DataController {
    
    static let shared = DataController()
    
    private init() {}
    
    private var rating = [Rating]()
    private var favorite = [Int]()
}

// MARK: Rating

extension DataController {
    
    func rateEpisode(_ episode: Episode, value: Double) {
        let epRated = Rating(id: episode.id, rate: .rated(value: value))
        
        if let index = rating.firstIndex(where: { $0.id == episode.id }) {
            rating[index] = epRated
        } else {
            rating.append(epRated)
        }
    }
    
    func removeRateEpisode(_ episode: Episode) {
        guard let index = rating.firstIndex(where: { $0.id == episode.id }) else {
            return
        }
        
        rating.remove(at: index)
    }
    
    func ratingForEpisode(_ episode: Episode) -> Rating? {
        rating.filter { $0.id == episode.id }.first
    }
}

// MARK: Favorite

extension DataController {
    
    func cleanFavorites() {
        favorite.removeAll()
    }
}


// MARK: Favorite - Cast

extension DataController {
    
    func isFavoriteCast(_ cast: Cast) -> Bool {
        favorite.contains(cast.id)
    }
    
    func addFavoriteCast(_ cast: Cast) {
        if !isFavoriteCast(cast) {
            favorite.append(cast.id)
        }
    }
    
    func removeFavoriteCast(_ cast: Cast) {
        guard let index = favorite.firstIndex(where: { $0 == cast.id }) else {
            return
        }
        
        favorite.remove(at: index)
    }
    
    func toogleFavorite(_ cast: Cast) {
        if isFavoriteCast(cast) {
            removeFavoriteCast(cast)
        } else {
            addFavoriteCast(cast)
        }
    }
}

// MARK: Favorite - Episode

extension DataController {
    
    func isFavoriteCast(_ episode: Episode) -> Bool {
        favorite.contains(episode.id)
    }
    
    func addFavoriteCast(_ episode: Episode) {
        if !isFavoriteCast(episode) {
            favorite.append(episode.id)
        }
    }
    
    func removeFavoriteCast(_ episode: Episode) {
        guard let index = favorite.firstIndex(where: { $0 == episode.id }) else {
            return
        }
        
        favorite.remove(at: index)
    }
    
    func toogleFavorite(_ episode: Episode) {
        if isFavoriteCast(episode) {
            removeFavoriteCast(episode)
        } else {
            addFavoriteCast(episode)
        }
    }
}
