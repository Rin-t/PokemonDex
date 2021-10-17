//
//  MosnterBallImageView.swift
//  Pokemondex
//
//  Created by Rin on 2021/10/17.
//

import UIKit

final class MonsterBallImageView: UIImageView {
    //MARK: - Methods
    init() {
        super.init(frame: .zero)
        image = UIImage(named: "モンスターボール")
        contentMode = .scaleAspectFit
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

