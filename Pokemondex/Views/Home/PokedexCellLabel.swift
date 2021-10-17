//
//  PokedexCellLabel.swift
//  Pokemondex
//
//  Created by Rin on 2021/09/18.
//

import UIKit

final class PokedexCellLabel: UILabel {

    init() {
        super.init(frame: .zero)
        textColor = .black
        textAlignment = .left
        font = .systemFont(ofSize: 25, weight: .regular)
        adjustsFontSizeToFitWidth = true
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder) 
    }
}
