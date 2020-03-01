//
//  Rate.swift
//  AppOfThrones
//
//  Created by Javier Laguna on 18/02/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import Foundation

enum Rate: Codable {
    case unrated
    case rated(value: Double)
    
    enum CodingKeys: String, CodingKey {
        case rate
        case value
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        let rate = try values.decode(String.self, forKey: .rate)
        switch rate {
        case "rated":
            let value = try values.decode(Double.self, forKey: .value)
            self = .rated(value: value)
        default:
            self = .unrated
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
               
        switch self {
        case .rated(let value):
            try container.encode("rated", forKey: .rate)
            try container.encode(value, forKey: .value)
        case .unrated:
            try container.encode("unrated", forKey: .rate)
        }
    }
}

struct Rating: Codable {
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
