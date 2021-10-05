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
import RxDataSources

final class HomeViewController: UIViewController {

    //MARK: - Propaties
    // collectionViewのcellId
    private let cellId = "cellId"
    // Apiで取得しでコードした情報を持つ
    private var pokemons = [Pokemon?]()
    private let viewModel = HomeViewModel()
    private let disposebag = DisposeBag()
    private var viewModel2:  HomeViewModel2!

    private lazy var datasource = RxCollectionViewSectionedReloadDataSource<PokemonDexCollectionModel>(configureCell: configureCell)

    private lazy var configureCell: RxCollectionViewSectionedReloadDataSource<PokemonDexCollectionModel>.ConfigureCell = { [weak self] (datasource, collectionView, indexPath, item) in
        guard let strongSelf = self else { return UICollectionViewCell()}
        switch item {
        case .specificPokeomnInfo:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PokedexCollectionViewCell
            return cell
        }
    }


    //MARK: - Views
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()

        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 30
        layout.sectionInset = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(PokedexCollectionViewCell.self, forCellWithReuseIdentifier: cellId)

        return collectionView
    }()

    

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupViewModel()
        setupCollectionView()
        confirmAndAdoptToiOSVersioin()
    }

    private func confirmAndAdoptToiOSVersioin() {
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
    private func setupViewModel() {
        viewModel2 = HomeViewModel2()

        viewModel2.items
            .bind(to: collectionView.rx.items(dataSource: datasource))
            .disposed(by: disposebag)

        viewModel2.updateItems()

    }

    private func setupCollectionView() {
        collectionView.rx.setDelegate(self).disposed(by: disposebag)
        collectionView.rx.itemSelected
            .subscribe (onNext: { [weak self] indexPath in
                guard let item = self?.datasource[indexPath] else { return }
                self?.collectionView.deselectItem(at: indexPath, animated: true)
            })
            .disposed(by: disposebag)
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

extension HomeViewController: UICollectionViewDelegate {

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

