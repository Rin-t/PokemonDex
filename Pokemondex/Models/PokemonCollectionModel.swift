//
//  PokemonCollectionModel.swift
//  Pokemondex
//
//  Created by Rin on 2021/10/04.
//

import Foundation
import RxDataSources

typealias PokemonDexCollectionModel = SectionModel<PokemonInfoSection, PokemonInfoItem>

enum PokemonInfoSection {
    case pokemonsInfo
}

enum PokemonInfoItem {
    case specificPokeomnInfo

    var titile: String {
        switch self {
        case .specificPokeomnInfo:
            return "pokemon"
        }
    }
}


