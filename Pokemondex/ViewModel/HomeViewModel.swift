//
//  HomeViewModel.swift
//  Pokemondex
//
//  Created by Rin on 2021/09/19.
//

import Foundation
import PKHUD

final class HomeViewModel {
    // 取得するポケモンの番号の範囲
    let pokemonIdRange = 1...151
    var pokemons = [Pokemon?]()

    func getPokemonName(complition: @escaping ([Pokemon?]) -> Void) {
        for id in pokemonIdRange {
            guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)/") else { return }
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if error != nil {
                    print("fail to fetch data")
                    complition([])
                    return
                }

                guard let data = data,
                      response != nil else {
                    print("data or response are nil")
                    complition([])
                    return
                }

                do {
                    let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                    self.pokemons.append(pokemon)
                } catch {
                    print("fail to decode")
                }
                if self.pokemons.count == self.pokemonIdRange.upperBound {
                    print(self.pokemons.last)
                    complition(self.pokemons)
                }
            }
            task.resume()
        }

    }
}
