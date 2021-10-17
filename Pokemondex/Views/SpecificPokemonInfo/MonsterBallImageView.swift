//
//  MosnterBallImageView.swift
//  Pokemondex
//
//  Created by Rin on 2021/10/17.
//

import UIKit

final class MonsterBallImageView: UIImageView {

    init() {
        super.init(frame: .zero)
        image = UIImage(named: "モンスターボール")
        frame.size = CGSize(width: 50, height: 50)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

