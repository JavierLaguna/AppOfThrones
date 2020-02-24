//
//  Cast.swift
//  AppOfThrones
//
//  Created by Javier Laguna on 17/02/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import Foundation

struct Cast: Decodable, Identifiable {
    
    var id: Int
    let avatar: String?
    let fullname: String?
    let role: String?
    let espisodes: Int?
    let birth: String?
    let placeBirth: String?
}
