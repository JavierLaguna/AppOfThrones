//
//  Rate.swift
//  AppOfThrones
//
//  Created by Javier Laguna on 18/02/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import Foundation

enum Rate {
    case unrated
    case rated(value: Double)
}

struct Rating {
    var id: Int
    var rate: Rate
}

// MARK: Equatable

extension Rating: Equatable {
    
    static func == (lhs: Rating, rhs: Rating) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: CustomStringConvertible

extension Rating: CustomStringConvertible {
    
    var description: String {
        let puntos: String
        switch rate {
        case .rated(let value):
            puntos = "Valorado con una puntuación de \(value)/10"
        default:
            puntos = "Sin puntuar"
        }
        
        return """
        Puntuacion:
            Id ->  \(id)
            Puntos -> \(puntos)
        
        """
    }
}
