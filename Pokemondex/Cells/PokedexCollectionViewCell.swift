//
//  PokedexCollectionViewCell.swift
//  Pokemondex
//
//  Created by Rin on 2021/09/18.
//

import UIKit

final class PokedexCollectionViewCell: UICollectionViewCell {

    //MARK: - Views
    let nameLabel = PokedexCellLabel()
    let idLabel = PokedexCellLabel()
    let monsterBallImageView = MonsterBallImageView()

    let pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    


    //MARK: - Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        let viewWidth = UIScreen.main.bounds.width
        print(viewWidth)
        self.layer.cornerRadius = 10
        self.backgroundColor = UIColor.rgb(red: 255, green: 248, blue: 220)

        // 影をつける
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowOpacity = 0.4
        self.layer.shadowRadius = 10

        let stackView = UIStackView(arrangedSubviews: [idLabel, nameLabel])
        stackView.axis = .horizontal
        stackView.spacing = viewWidth * 0.05

        let baseStackView = UIStackView(arrangedSubviews: [pokemonImageView, stackView, monsterBallImageView])
        baseStackView.axis = .horizontal
        baseStackView.spacing = viewWidth * 0.04

        addSubview(baseStackView)

        pokemonImageView.anchor(width: 60)
        monsterBallImageView.anchor(width: 20)
        idLabel.anchor(width: viewWidth * 0.14)
        baseStackView.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, width: UIScreen.main.bounds.width - 80, height: 50, topPadding: 10, bottomPadding: 10, leftPadding: viewWidth * 0.03, rightPadding: viewWidth * 0.03)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder) 
    }
}
