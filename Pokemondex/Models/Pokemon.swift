//
//  Pokemon.swift
//  Pokemondex
//
//  Created by Rin on 2021/09/18.
//

import Foundation

struct Pokemon: Codable {
    let name: String
    let id: Int
    let sprites: Images
}

struct Images: Codable {
    let frontImage: String

    enum CodingKeys: String, CodingKey {
        case frontImage = "front_default"
    }
}
