//
//  PokeminImageView.swift
//  Pokemondex
//
//  Created by Rin on 2021/09/20.
//

import UIKit
import SDWebImage

final class PokemonImageView: UIImageView {

    init() {
        super.init(frame: .zero)
        image = UIImage(named: "モンスターボール")
        frame.size = CGSize(width: 50, height: 50)
    }

    init(pokeonImage: String?) {
        super.init(frame: .zero)
        contentMode = .scaleAspectFit
        let url = URL(string: pokeonImage ?? "")
        sd_setImage(with: url)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder) 
    }
}
