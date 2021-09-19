//
//  PokeminImageView.swift
//  Pokemondex
//
//  Created by Rin on 2021/09/20.
//

import UIKit
import SDWebImage

final class PokemonImageView: UIImageView {

    // モンスターボールの画像をセット
    init() {
        super.init(frame: .zero)
        image = UIImage(named: "モンスターボール")
        frame.size = CGSize(width: 50, height: 50)
    }

    // ポケモンの画像を表示
    init(pokeonImage: String?) {
        super.init(frame: .zero)
        contentMode = .scaleAspectFit
        let url = URL(string: pokeonImage ?? "")
        sd_setImage(with: url)
    }

  

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
