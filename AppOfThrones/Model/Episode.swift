//
//  Episode.swift
//  AppOfThrones
//
//  Created by Javier Laguna on 13/02/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import Foundation

class Episode: Decodable {
    
    let id: Int
    let name: String?
    let date: String?
    let image: String?
    let episode: Int
    let season: Int
    let overview: String
    
    init(id: Int,
         name: String?,
         date: String?,
         image: String?,
         episode: Int,
         season: Int,
         overview: String) {
        
        self.id = id
        self.name = name
        self.date = date
        self.image = image
        self.episode = episode
        self.season = season
        self.overview = overview
    }
}
