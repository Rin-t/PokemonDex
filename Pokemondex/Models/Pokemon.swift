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
    let types: [Types]
}

struct Images: Codable {
    let frontImage: String
    let shinyImage: String

    enum CodingKeys: String, CodingKey {
        case frontImage = "front_default"
        case shinyImage = "front_shiny"
    }
}

struct Types: Codable {
    let type: Type
}

struct Type: Codable {
    let name: String
}
