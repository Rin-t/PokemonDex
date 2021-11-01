//
//  PokemonNameLabel.swift
//  Pokemondex
//
//  Created by Rin on 2021/09/20.
//

import UIKit

final class PokemonIdLabel: UILabel {
    //MARK: - Methods
    init(pokemonId: Int?) {
        super.init(frame: .zero)
        guard let id = pokemonId else { return }
        text = "No. " + String(id)
        font = .systemFont(ofSize: 15, weight: .regular)
        textColor = .black
        backgroundColor = UIColor.rgb(red: 255, green: 248, blue: 220)
        textAlignment = .center
        layer.cornerRadius = 10
        clipsToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
