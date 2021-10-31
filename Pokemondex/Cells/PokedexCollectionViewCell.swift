//
//  PokedexCollectionViewCell.swift
//  Pokemondex
//
//  Created by Rin on 2021/09/18.
//

import UIKit

final class PokedexCollectionViewCell: UICollectionViewCell {

    //MARK: - Views
    let nameLabel: PokedexCellLabel = {
        let label = PokedexCellLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "nameLabel"
        return label
    }()

    let idLabel: PokedexCellLabel = {
        let idLabel = PokedexCellLabel()
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        idLabel.accessibilityIdentifier = "idLabel"
        return idLabel
    }()

    let monsterBallImageView: MonsterBallImageView = {
        let imageView = MonsterBallImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.accessibilityIdentifier = "monsterBallImageView"
        return imageView
    }()

    let pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.accessibilityIdentifier = "pokemonImageView"
        return imageView
    }()
    


    //MARK: - Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        let viewWidth = UIScreen.main.bounds.width
        self.layer.cornerRadius = 10
        self.backgroundColor = UIColor.rgb(red: 255, green: 248, blue: 220)

        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowOpacity = 0.4
        self.layer.shadowRadius = 10

        let stackView = UIStackView(arrangedSubviews: [pokemonImageView, idLabel, nameLabel, monsterBallImageView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.setCustomSpacing(16, after: pokemonImageView)
        stackView.setCustomSpacing(16, after: idLabel)
        stackView.setCustomSpacing(16, after: nameLabel)
        stackView.distribution = .fill

        addSubview(stackView)

        pokemonImageView.anchor(width: 60)
        idLabel.anchor(width: 100)
        monsterBallImageView.anchor(width: 20)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
         
    }

    func configure(imageURL: URL?, name: String, id: Int) {
        pokemonImageView.sd_setImage(with: imageURL)
        nameLabel.text = name
        idLabel.text = "No." + String(id)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder) 
    }
}
