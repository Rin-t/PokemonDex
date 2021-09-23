//
//  PokemonNameLabel.swift
//  Pokemondex
//
//  Created by Rin on 2021/09/22.
//

import UIKit

final class PokemonNameLabel: UILabel {
    init(pokemonName: String?) {
        super.init(frame: .zero)
        guard let name = pokemonName else { return }
        text = name
        font = .systemFont(ofSize: 35, weight: .regular)
        textColor = .darkGray
        backgroundColor = UIColor.rgb(red: 255, green: 248, blue: 220)
        textAlignment = .center
        layer.cornerRadius = 10
        clipsToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
