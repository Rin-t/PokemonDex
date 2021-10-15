//
//  HomeViewModel.swift
//  Pokemondex
//
//  Created by Rin on 2021/09/19.
//

import Foundation
import RxCocoa
import RxSwift
import RxDataSources

final class HomeViewModel {

    let pokemonIdRange = 1...151
    var pokemons = [Pokemon]()

    let items = BehaviorRelay<[PokemonDexCollectionModel]>(value: [])
    var itemObserbable: Observable<[PokemonDexCollectionModel]> {
        return items.asObservable()
    }

    func setup() {
        Task {
            let pokemons = await fetchPokemonsData()
            updateItems(pokemons: pokemons)
        }
    }

    func updateItems(pokemons: [Pokemon]) {
        var sections: [PokemonDexCollectionModel] = []
        let pokemonItems = pokemons.map { PokemonInfoItem.specificPokeomnInfo(pokemon: $0) }
        let pokemonInfoSection = PokemonDexCollectionModel(model: .pokemonsInfo, items: pokemonItems)
        sections.append(pokemonInfoSection)
        items.accept(sections)
    }

    private func fetchPokemonsData() async -> [Pokemon] {
        for id in pokemonIdRange {
            guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)/") else { return []}
            do {
                let (fetchedData, _) = try await URLSession.shared.data(from: url)
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: fetchedData)
                self.pokemons.append(pokemon)
            } catch {
                print("error")
            }
        }
        return pokemons
   }
}
