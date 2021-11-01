//
//  ViewController.swift
//  Pokemondex
//
//  Created by Rin on 2021/09/18.
//

import UIKit
import SDWebImage
import RxSwift
import RxCocoa
import RxDataSources
import PKHUD

final class HomeViewController: UIViewController, AdoptNewiOSVersionProtocol {
    //MARK: - Propaties
    private let cellId = "cellId"
    private var viewModel: HomeViewModel!
    private let disposebag = DisposeBag()

    private lazy var datasource = RxCollectionViewSectionedReloadDataSource<PokemonDexCollectionModel>(configureCell: configureCell)
    private lazy var configureCell: RxCollectionViewSectionedReloadDataSource<PokemonDexCollectionModel>.ConfigureCell = { [weak self] (datasource, collectionView, indexPath, item) in
        guard let strongSelf = self else { return UICollectionViewCell()}
        switch item {
        case .specificPokeomnInfo(let pokemon):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: strongSelf.cellId, for: indexPath) as! PokedexCollectionViewCell
            let url = URL(string: pokemon.sprites.frontImage)
            cell.configure(imageURL: url, name: pokemon.name, id: pokemon.id)
            return cell
        }
    }

    //MARK: - Views
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 30
        layout.sectionInset = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PokedexCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.accessibilityIdentifier = "homeCollectionView"
        return collectionView
    }()

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupViewModel()
        setupCollectionView()
        navigationbarAdoptToiOS15()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize = CGSize(width: collectionView.bounds.width * 0.9, height: 80)
    }


    //MARK: - Methods
    private func setupViewModel() {
        viewModel = HomeViewModel(viewController: self)

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
                    let nextVC = SpecificPokemoninfoViewController.instantiate(pokemon: pokemon)
                    self?.navigationController?.pushViewController(nextVC, animated: true)
                }
            })
            .disposed(by: disposebag)
    }

    private func setupLayout() {
        navigationItem.title = "PokeList"
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.anchor(top: view.topAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor)
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func showHud() {
        DispatchQueue.main.async {
            HUD.show(.progress, onView: nil)
        }
    }

    func stopHud() {
        DispatchQueue.main.async {
            HUD.hide()
        }
    }

    func showFailAPICallAlert(title: String, message: String) {
        showAlert(title: title, message: message)
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)

        alert.addAction(action)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension HomeViewController: UICollectionViewDelegate {}

