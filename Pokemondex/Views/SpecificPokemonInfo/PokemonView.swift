//
//  PokemonImageView.swift
//  Pokemondex
//
//  Created by Rin on 2021/09/20.
//

import UIKit

final class PokemonView: UIView {

    private var pokemon: Pokemon?

    //MARK: - Views
    private lazy var imageView = PokemonImageView(pokeonImage: pokemon?.sprites.frontImage)
    //private lazy var firstType = 

    init(pokemon: Pokemon?) {
        super.init(frame: .zero)
        self.pokemon = pokemon
        setupLayout()
    }

    private func setupLayout() {

        layer.cornerRadius = 10
        clipsToBounds = true
        backgroundColor = UIColor.rgb(red: 255, green: 248, blue: 220)

        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 8, height: 8)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 10

        addSubview(imageView)
        imageView.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}