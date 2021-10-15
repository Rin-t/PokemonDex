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
    private var viewModel: HomeViewModel!
    private let disposebag = DisposeBag()

    private lazy var datasource = RxCollectionViewSectionedReloadDataSource<PokemonDexCollectionModel>(configureCell: configureCell)

    private lazy var configureCell: RxCollectionViewSectionedReloadDataSource<PokemonDexCollectionModel>.ConfigureCell = { [weak self] (datasource, collectionView, indexPath, item) in
        guard let strongSelf = self else { return UICollectionViewCell()}
        switch item {
        case .specificPokeomnInfo(let pokemon):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PokedexCollectionViewCell
            let url = URL(string: pokemon.sprites.frontImage)
            cell.pokemonImageView.sd_setImage(with: url)
            cell.nameLabel.text = pokemon.name
            cell.idLabel.text = "No." + String(pokemon.id)
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

    private func setupViewModel() {
        viewModel = HomeViewModel()

        viewModel.items
            .bind(to: collectionView.rx.items(dataSource: datasource))
            .disposed(by: disposebag)

        viewModel.setup()

    }

    private func setupCollectionView() {
        collectionView.rx.setDelegate(self).disposed(by: disposebag)
        collectionView.rx.itemSelected
            .map { [weak self] indexPath -> PokemonInfoItem? in
                return self?.datasource[indexPath]
            }
            .subscribe (onNext: { [weak self] item in
                guard let item = item else { return }
                switch item {
                case .specificPokeomnInfo(let pokemon):
                    let nextVC = SpecificPokemoninfoViewController()
                    nextVC.pokemon = pokemon
                    self?.navigationController?.pushViewController(nextVC, animated: true)
                }
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
    
}

