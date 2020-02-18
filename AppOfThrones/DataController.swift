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
