//
//  PokeminImageView.swift
//  Pokemondex
//
//  Created by Rin on 2021/09/20.
//

import UIKit
import SDWebImage

final class PokemonImageView: UIImageView {
    //MARK: - Methods
    init(pokeonImage: String?) {
        super.init(frame: .zero)
        contentMode = .scaleAspectFit
        let url = URL(string: pokeonImage ?? "question")
        sd_setImage(with: url)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
