//
//  PokemonImageView.swift
//  Pokemondex
//
//  Created by Rin on 2021/09/20.
//

import UIKit

final class PokemonView: UIView {

    //MARK: - Propaties
    private var pokemon: Pokemon?

    //MARK: - Views
    lazy var imageView = PokemonImageView(pokeonImage: pokemon?.sprites.frontImage)
    private lazy var pokemonNameLabel = PokemonNameLabel(pokemonName: pokemon?.name)
    private lazy var firstTypeLabel = PokemonTypeLabel(types: pokemon?.types ?? [], typePosession: .typeOne)
    private lazy var secondTypeLabel = PokemonTypeLabel(types: pokemon?.types ?? [], typePosession: .typeTwo)

    //MARK: - Methods
    init(pokemon: Pokemon?) {
        super.init(frame: .zero)
        self.pokemon = pokemon
        setupLayout()
    }

    private func setupLayout() {
        let viewHeight = UIScreen.main.bounds.height
        let viewWidth = UIScreen.main.bounds.width

        layer.cornerRadius = 10
        clipsToBounds = true
        backgroundColor = UIColor.rgb(red: 255, green: 248, blue: 220)

        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 8, height: 8)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 10

        let stackView = UIStackView(arrangedSubviews: [firstTypeLabel, secondTypeLabel])
        stackView.axis = .horizontal
        stackView.spacing = 20

        addSubview(imageView)
        addSubview(stackView)
        addSubview(pokemonNameLabel)

        pokemonNameLabel.anchor(top: topAnchor, left: leftAnchor, topPadding: viewHeight * 0.02, leftPadding: viewWidth * 0.08)
        imageView.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, width: viewWidth * 0.8)
        stackView.anchor(bottom: bottomAnchor, left: leftAnchor, height: 45, bottomPadding: viewHeight * 0.02, leftPadding: viewWidth * 0.08)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder) 
    }
}
