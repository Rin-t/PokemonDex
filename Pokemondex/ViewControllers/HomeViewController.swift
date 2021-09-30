//
//  ViewController.swift
//  Pokemondex
//
//  Created by Rin on 2021/09/18.
//

import UIKit
import PKHUD
import SDWebImage
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {

    //MARK: - Propaties
    // collectionViewのcellId
    private let cellId = "cellId"
    // Apiで取得しでコードした情報を持つ
    private var pokemons = [Pokemon?]()
    private let viewModel = HomeViewModel()
    private let dispodebag = DisposeBag()


    //MARK: - Views
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()

        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 30
        layout.sectionInset = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(PokedexCollectionViewCell.self, forCellWithReuseIdentifier: cellId)

        return collectionView
    }()

    

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        getPokemonData()

        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.backgroundColor = .systemPink
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        } else {
            navigationController?.navigationBar.barTintColor = .systemPink
        }
    }

    /// PokemonApiからデータを取得
    private func getPokemonData() {

        let pokemons: Observable<[Pokemon]> = viewModel.pokemons

        viewModel.pokemons2
            


        viewModel.getPokemonName()
//        HUD.show(.progress)
//        viewModel.getPokemonName { pokemons in
//            self.pokemons = pokemons
//            self.pokemons.sort(by: { $0!.id < $1!.id })
//            DispatchQueue.main.async {
//                self.collectionView.reloadData()
//                HUD.hide()
//            }
//        }
    }

    /// HomeViewのレイアウトを作成
    private func setupLayout() {
        navigationItem.title = "PokeList"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.anchor(top: view.topAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, topPadding: 60, bottomPadding: 0, leftPadding: 0, rightPadding: 0)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemons.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PokedexCollectionViewCell
        // api通信が終わっていなくてデータがない場合はこれ以上進まない
        if pokemons.count == 0 { return cell }
        cellLayout(cell: cell, pokemon: pokemons[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextVC = SpecificPokemoninfoViewController()
        nextVC.pokemon = pokemons[indexPath.row]
        self.navigationController?.pushViewController(nextVC, animated: true)
    }


    /// cellのレイアウト
    /// - Parameters:
    ///   - cell: PokedexCollectionViewCell
    ///   - pokemon: api通信で取得したデータ
    private func cellLayout(cell: PokedexCollectionViewCell, pokemon: Pokemon?) {
        guard let url = URL(string: pokemon?.sprites.frontImage ?? "") else { return }
        cell.pokemonImageView.sd_setImage(with: url)
        cell.nameLabel.text = pokemon?.name
        cell.idLabel.text = "No." + String(pokemon?.id ?? 0)
    }

}

