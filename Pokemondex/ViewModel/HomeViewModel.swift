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
        fetchPokemonsInfo { [weak self] pokemons in
            var sortedPokemonData = pokemons
            sortedPokemonData.sort(by: { $0.id < $1.id})
            self?.updateItems(pokemons: sortedPokemonData)
        }
    }

    func updateItems(pokemons: [Pokemon]) {
        var sections: [PokemonDexCollectionModel] = []
        let pokemonItems = pokemons.map { PokemonInfoItem.specificPokeomnInfo(pokemon: $0) }
        let pokemonInfoSection = PokemonDexCollectionModel(model: .pokemonsInfo, items: pokemonItems)
        sections.append(pokemonInfoSection)
        items.accept(sections)
    }


    private func fetchPokemonsInfo(completion: @escaping ([Pokemon]) -> ()) {
        for id in pokemonIdRange {
            guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)/") else { return }
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if error != nil {
                    print("fail to fetch data")
                    return
                }

                guard let data = data,
                      response != nil else {
                          print("data or response are nil")
                          return
                      }
                do {
                    let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                    self.pokemons.append(pokemon)
                } catch {
                    print("fail to decode")
                }

                if self.pokemons.count == self.pokemonIdRange.upperBound {
                    completion(self.pokemons)
                }
            }
            task.resume()
        }

    }

}
