//
//  House.swift
//  AppOfThrones
//
//  Created by Javier Laguna on 18/02/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import Foundation

struct House: Decodable, Equatable {
    
    let imageName: String?
    let name: String?
    let words: String?
    let seat: String?
}

// MARK: CustomStringConvertible

extension House: CustomStringConvertible {
    
    var description: String {
        return """
        Casa: \(name ?? "")
            Lema -> \(words ?? "")
            Lugar -> \(seat ?? "")
            Imagen -> \(imageName ?? "")
        
        """
    }
}
