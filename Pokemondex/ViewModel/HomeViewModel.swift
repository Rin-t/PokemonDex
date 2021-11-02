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

protocol HomeViewModelInput {
    func viewDidLoad()
}

protocol HomeViewModelOutput: AnyObject {
    var event: Observable<HomeViewModel.Event> { get }
    var items: Observable<[PokemonDexCollectionModel]> { get }
}

protocol HomeViewModelType {
    var inputs: HomeViewModelInput { get }
    var outputs: HomeViewModelOutput { get }
}

final class HomeViewModel {

    enum Event {
        case alert(_ action: AlertActionType)
        case indicator(_ action: IndicatorActionType)

        enum AlertActionType {
            case show(title: String, message: String)
            case hide
        }
        enum IndicatorActionType {
            case start
            case stop
        }
    }
    private let pokemonUseCase = PokemonUseCase()
    private let itemsRelay = PublishRelay<[PokemonDexCollectionModel]>()
    private let eventRelay = PublishRelay<Event>()
    private let disposebag = DisposeBag()

    init() {
        pokemonUseCase.pokemonDexCollectionModels
            .subscribe(onNext: itemsRelay.accept(_:))
            .disposed(by: disposebag)
    }

    private func fetchPokemonsData() async throws -> [Pokemon] {
        let pokemonIdRange = 1...151
        var pokemons = [Pokemon]()
        do {
            try await withThrowingTaskGroup(of: (Data, URLResponse).self) { group in
                for id in pokemonIdRange {
                    group.addTask {
                        // guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)/") else { fatalError() }
                        //let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)/")!
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
            print("failToFetchData")
            throw APICallError.failToFetchData
        }
        return pokemons
   }

}

// MARK: - Input
extension HomeViewModel: HomeViewModelInput {

    func viewDidLoad() {
        Task {
            do {
                eventRelay.accept(.indicator(.start))
                let pokemons = try await fetchPokemonsData()
                pokemonUseCase.update(pokemons: pokemons)
                eventRelay.accept(.indicator(.stop))
            } catch let error as APICallError {
                eventRelay.accept(.alert(.show(title: error.title,
                                               message: error.message)))
                eventRelay.accept(.indicator(.stop))
            }
        }
    }

}

// MARK: - Output
extension HomeViewModel: HomeViewModelOutput {

    var event: Observable<Event> {
        eventRelay.asObservable()
    }

    var items: Observable<[PokemonDexCollectionModel]> {
        itemsRelay.asObservable()
    }

}

extension HomeViewModel: HomeViewModelType {

    var inputs: HomeViewModelInput {
        return self
    }

    var outputs: HomeViewModelOutput {
        return self
    }

}

////MARK: - Rxに変えたい
//protocol HomeViewModelDelegate: AnyObject ,ApiAlertProtocol, HudProtocol {}
//
//protocol ApiAlertProtocol {
//    func showFailAPICallAlert(title: String, message: String)
//}
//
//protocol HudProtocol {
//    func stopHud()
//    func showHud()
//}
//
//final class HomeViewModel {
//    //MARK: - Propaties
//    let items = BehaviorRelay<[PokemonDexCollectionModel]>(value: [])
//    private var itemObserbable: Observable<[PokemonDexCollectionModel]> {
//        return items.asObservable()
//    }
//    //let isHudShown: Observable<Bool>
//    private weak var homeViewController: HomeViewModelDelegate?
//
//    //MARK: - Methods
//
//    init(viewController: HomeViewModelDelegate) {
//        homeViewController = viewController
//    }
//
//    func setup() {
//        Task {
//            do {
//                homeViewController?.showHud()
//                let pokemons = try await fetchPokemonsData()
//                updateItems(pokemons: pokemons)
//                homeViewController?.stopHud()
//            } catch let error as APICallError {
//                homeViewController?.showFailAPICallAlert(title: error.title, message: error.message)
//                homeViewController?.stopHud()
//            }
//        }
//    }
//
//    private func updateItems(pokemons: [Pokemon]) {
//        var sections: [PokemonDexCollectionModel] = []
//        let pokemonItems = pokemons.map { PokemonInfoItem.specificPokeomnInfo(pokemon: $0) }
//        let pokemonInfoSection = PokemonDexCollectionModel(model: .pokemonsInfo, items: pokemonItems)
//        sections.append(pokemonInfoSection)
//        items.accept(sections)
//    }
//
//    private func fetchPokemonsData() async throws -> [Pokemon] {
//        let pokemonIdRange = 1...151
//        let urls = try pokemonIdRange.map { (n: Int) -> URL in
//            guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(n)/") else { throw APICallError.unconvertibleToURL }
//            return url
//        }
//        var pokemons = [Pokemon]()
//        do {
//            try await withThrowingTaskGroup(of: (Data, URLResponse).self) { group in
//                for url in urls {
//                    group.addTask {
//                        return try await URLSession.shared.data(from: url)
//                    }
//                }
//
//                for try await (fetchedData, _) in group {
//                    let pokemon = try JSONDecoder().decode(Pokemon.self, from: fetchedData)
//                    pokemons.append(pokemon)
//                    pokemons.sort(by: { $0.id < $1.id } )
//                }
//            }
//        } catch {
//            print("failToFetchData")
//            throw APICallError.failToFetchData
//        }
//        return pokemons
//   }
//}
