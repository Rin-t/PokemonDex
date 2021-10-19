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
    //MARK: - Propaties
    let items = BehaviorRelay<[PokemonDexCollectionModel]>(value: [])
    private var itemObserbable: Observable<[PokemonDexCollectionModel]> {
        return items.asObservable()
    }

    let isHudShown: Observable<Bool>


    //MARK: - Methods
    func setup() {
        Task {
            do {
                let pokemons = try await fetchPokemonsData()
                updateItems(pokemons: pokemons)
            } catch let error as APICallError {
                switch error {
                case .failToFetchData:
                    print("failToFetchData")
                case .unconvertibleToURL:
                    print("unconvertibleToURL")
                }
            }
        }
    }

    private func updateItems(pokemons: [Pokemon]) {
        var sections: [PokemonDexCollectionModel] = []
        let pokemonItems = pokemons.map { PokemonInfoItem.specificPokeomnInfo(pokemon: $0) }
        let pokemonInfoSection = PokemonDexCollectionModel(model: .pokemonsInfo, items: pokemonItems)
        sections.append(pokemonInfoSection)
        items.accept(sections)
    }

    private func fetchPokemonsData() async throws -> [Pokemon] {
        let pokemonIdRange = 1...151
        var pokemons = [Pokemon]()

        do {
            try await withThrowingTaskGroup(of: (Data, URLResponse).self) { group in
                for id in pokemonIdRange {
                    group.addTask {
                        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)/") else { throw APICallError.unconvertibleToURL }
                        return try await URLSession.shared.data(from: url)
                    }
                }

                for try await (fetchedData, _) in group {
                    let pokemon = try JSONDecoder().decode(Pokemon.self, from: fetchedData)
                    pokemons.append(pokemon)
                    pokemons.sort(by: { $0.id < $1.id } )
                }
            }
        } catch {
            throw APICallError.failToFetchData
        }
        return pokemons
   }
}
