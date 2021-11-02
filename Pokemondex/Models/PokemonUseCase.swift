//
//  PokemonUseCase.swift
//  Pokemondex
//
//  Created by Rin on 2021/11/01.
//

import Foundation
import RxCocoa
import RxSwift

final class PokemonUseCase {

     private let disposebag = DisposeBag()
     private let updatePokemonsTrigger = PublishRelay<[Pokemon]>()
     private let pokemonDexCollectionModelsRelay = PublishRelay<[PokemonDexCollectionModel]>()
     var pokemonDexCollectionModels: Observable<[PokemonDexCollectionModel]> {
         pokemonDexCollectionModelsRelay.asObservable()
     }

     init() {
         updatePokemonsTrigger
             .subscribe(onNext: { [weak self] pokemons in
                 var sections: [PokemonDexCollectionModel] = []
                 let pokemonItems = pokemons.map { PokemonInfoItem.specificPokeomnInfo(pokemon: $0) }
                 let pokemonInfoSection = PokemonDexCollectionModel(model: .pokemonsInfo, items: pokemonItems)
                 sections.append(pokemonInfoSection)
                 self?.pokemonDexCollectionModelsRelay.accept(sections)
             })
             .disposed(by: disposebag)
     }

     func update(pokemons: [Pokemon]) {
         updatePokemonsTrigger.accept(pokemons)
     }

 }
