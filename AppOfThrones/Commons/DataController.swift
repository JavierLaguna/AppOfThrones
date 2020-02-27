//
//  DataController.swift
//  AppOfThrones
//
//  Created by Javier Laguna on 18/02/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import Foundation

final class DataController {
    
    // MARK: Singleton
    static let shared = DataController()
    
    private init() {}
    
    // MARK: Private Variables
    
    lazy private var decoder = JSONDecoder()
    private var rating = [Rating]() {
        didSet {
            notifyRatingDidChanged()
        }
    }
    private var favorite = [Int]() {
        didSet {
            notifyFavoriteDidChanged()
        }
    }
}

// MARK: GetData

extension DataController {
    
    func getAllEpisodes() -> [Episode] {
        var episodes = [Episode]()
        
        for n in 1...Constants.Episodes.numberOfSeasons {
            episodes.append(contentsOf: getEpisodes(of: n))
        }
        
        return episodes
    }
    
    func getEpisodes(of seasonNumber: Int) -> [Episode] {
        let season = "season_\(seasonNumber)"
        guard let pathURL = Bundle.main.url(forResource: season, withExtension: "json") else {
            return [Episode]()
        }
        
        do {
            let data = try Data(contentsOf: pathURL)
            return try decoder.decode([Episode].self, from: data)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func getCast() -> [Cast] {
        guard let pathURL = Bundle.main.url(forResource: "cast", withExtension: "json") else {
            return [Cast]()
        }
        
        do {
            let data = try Data(contentsOf: pathURL)
            return try decoder.decode([Cast].self, from: data)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func getHouses() -> [House] {
        guard let pathURL = Bundle.main.url(forResource: "houses", withExtension: "json") else {
            return [House]()
        }
        
        do {
            let data = try Data(contentsOf: pathURL)
            return try decoder.decode([House].self, from: data)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
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
    
    func cleanRating() {
        rating.removeAll()
    }
    
    // MARK: Rating - Private functions
    
    private func notifyRatingDidChanged() {
        NotificationCenter.default.post(name: Constants.NotificationCenter.ratesChanged, object: nil)
    }
}

// MARK: Favorite

extension DataController {
    
    func isFavorite<T: Identifiable>(_ value: T) -> Bool {
        favorite.contains(value.id)
    }
    
    func addFavorite<T: Identifiable>(_ value: T) {
        if !isFavorite(value) {
            favorite.append(value.id)
        }
    }
    
    func removeFavorite<T: Identifiable>(_ value: T) {
        guard let index = favorite.firstIndex(where: { $0 == value.id }) else {
            return
        }
        
        favorite.remove(at: index)
    }
    
    func toogleFavorite<T: Identifiable>(_ value: T) {
        if isFavorite(value) {
            removeFavorite(value)
        } else {
            addFavorite(value)
        }
    }
    
    func cleanFavorites() {
        favorite.removeAll()
    }
    
    // MARK: Favorite - Private functions
    
    private func notifyFavoriteDidChanged() {
        NotificationCenter.default.post(name: Constants.NotificationCenter.favoritesChanged, object: nil)
    }
}

