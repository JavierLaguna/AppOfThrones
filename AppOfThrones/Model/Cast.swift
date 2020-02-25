//
//  Cast.swift
//  AppOfThrones
//
//  Created by Javier Laguna on 17/02/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import Foundation

struct Cast: Identifiable, Decodable, Equatable {
    
    let id: Int
    let avatar: String?
    let fullname: String?
    let role: String?
    let episodes: Int?
    let birth: String?
    let placeBirth: String?
}

// MARK: CustomStringConvertible

extension Cast: CustomStringConvertible {
    
    var description: String {
        return """
        Actor: \(fullname ?? "")
            Personaje -> \(role ?? "")
            Id -> \(id)
            Avatar -> \(avatar ?? "")
            Nº de episodios -> \(episodes ?? 0)
            Fecha Nacimiento -> \(birth ?? "")
            Lugar Nacimiento -> \(placeBirth ?? "")
        
        """
    }
}
