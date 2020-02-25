//
//  Episode.swift
//  AppOfThrones
//
//  Created by Javier Laguna on 13/02/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import Foundation

struct Episode: Identifiable, Decodable, Equatable {
    
    let id: Int
    let name: String?
    let date: String?
    let image: String?
    let episode: Int
    let season: Int
    let overview: String
}

// MARK: CustomStringConvertible

extension Episode: CustomStringConvertible {
    
    var description: String {
        return """
        Episodio: \(episode)-\(season) \(name ?? "")
            Id -> \(id)
            Fecha -> \(date ?? "")
            Imagen -> \(image ?? "")
            Descripción ->
                \(overview)
        
        """
    }
}
