//
//  ViewController.swift
//  Pokemondex
//
//  Created by Rin on 2021/09/18.
//

import UIKit

class HomeViewController: UIViewController {

    //MARK: - Propaties
    // collectionViewのcellId
    private let cellId = "cellId"
    // Apiで取得しでコードした情報を持つ
    var pokemons: Pokemon?

    //MARK: - Views
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.rgb(red: 255, green: 248, blue: 220)
        collectionView.register(PokedexCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        return collectionView
    }()

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }

    override func viewWillLayoutSubviews() {
        setupLayout()
    }

    /// HomeViewのレイアウトを作成
    private func setupLayout() {
        view.backgroundColor = UIColor.rgb(red: 255, green: 248, blue: 220)
        view.addSubview(collectionView)
        collectionView.anchor(top: view.topAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, topPadding: 60)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PokedexCollectionViewCell
        

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }

}

