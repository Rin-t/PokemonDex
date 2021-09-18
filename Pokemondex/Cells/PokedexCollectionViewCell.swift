//
//  PokedexCollectionViewCell.swift
//  Pokemondex
//
//  Created by Rin on 2021/09/18.
//

import UIKit

final class PokedexCollectionViewCell: UICollectionViewCell {

//    var pokemon: Pokemon? {
//        didSet {
//            nameLabel.text = pokemon?.name
//            idLabel.text = String(pokemon?.id ?? 0)
//        }
//    }

    //MARK: - Views
    let nameLabel = PokedexCellLabel(_text: "Pikachu")
    let idLabel = PokedexCellLabel(_text: "No.015")

    let pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ピカチュウ")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    let monsterBallImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "モンスターボール")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    //MARK: - Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 10
        self.backgroundColor = .systemGray2

        // 
        let stackView = UIStackView(arrangedSubviews: [idLabel, nameLabel])
        stackView.axis = .horizontal
        stackView.spacing = 10

        //
        let baseStackView = UIStackView(arrangedSubviews: [pokemonImageView, stackView, monsterBallImageView])
        baseStackView.axis = .horizontal
        baseStackView.spacing = 15

        addSubview(baseStackView)

        pokemonImageView.anchor(width: 40, height: 40)
        monsterBallImageView.anchor(width: 20, height: 20)
        idLabel.anchor(width: 80)
        baseStackView.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, width: UIScreen.main.bounds.width - 80, height: 40, topPadding: 10, bottomPadding: 10, leftPadding: 10, rightPadding: 10)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
