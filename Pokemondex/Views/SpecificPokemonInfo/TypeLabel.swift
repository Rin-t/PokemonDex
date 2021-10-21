//
//  TypeLabel.swift
//  Pokemondex
//
//  Created by Rin on 2021/09/20.
//

import UIKit

enum PokemonType: String {
    case normal = "normal",
         fire = "fire",
         water = "water",
         grass = "grass",
         electric = "electric",
         ice = "ice",
         fighting = "fighting",
         poison = "poison",
         ground = "ground",
         flying = "flying",
         psychic = "psychic",
         bug = "bug",
         rock = "rock" ,
         ghost = "ghost",
         dark = "dark",
         dragon = "dragon",
         fairy = "fairy"

    var color: UIColor {
        switch self {
        case .normal: return UIColor.rgb(red: 255, green: 218, blue: 183)
        case .fire: return UIColor.rgb(red: 255, green: 69, blue: 0)
        case .water: return UIColor.rgb(red: 65, green: 105, blue: 225)
        case .grass: return UIColor.rgb(red: 60, green: 179, blue: 113)
        case .electric: return UIColor.rgb(red: 255, green: 215, blue: 0)
        case .ice: return UIColor.rgb(red: 135, green: 206, blue: 235)
        case .fighting: return UIColor.rgb(red: 255, green: 99, blue: 71)
        case .poison: return UIColor.rgb(red: 186, green: 85, blue: 211)
        case .ground: return UIColor.rgb(red: 205, green: 133, blue: 63)
        case .flying: return UIColor.rgb(red: 100, green: 149, blue: 237)
        case .psychic: return UIColor.rgb(red: 238, green: 130, blue: 238)
        case .bug: return UIColor.rgb(red: 144, green: 238, blue: 144)
        case .rock: return UIColor.rgb(red: 210, green: 180, blue: 140)
        case .ghost: return UIColor.rgb(red: 72, green: 61, blue: 139)
        case .dark: return UIColor.rgb(red: 105, green: 105, blue: 105)
        case .dragon: return UIColor.rgb(red: 240, green: 100, blue: 100)
        case .fairy: return UIColor.rgb(red: 255, green: 192, blue: 203)
        }
    }
}

enum TypePosession {
    case typeOne, typeTwo
}

final class PokemonTypeLabel: UILabel {
    //MARK: - Methods
    init(types: [Types], typePosession: TypePosession) {
        super.init(frame: .zero)
        switch typePosession {
        case .typeOne:
            if types.isEmpty { return }
            let type = types[0].type.name
            setupLabelTextAndBackgroundColor(type: type)
        case .typeTwo:
            if types.count < 2 { return }
            let type = types[1].type.name
            setupLabelTextAndBackgroundColor(type: type)
        }
        textAlignment = .center
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.gray.cgColor
        textColor = .white
        clipsToBounds = true
        font = .systemFont(ofSize: 20, weight: .bold)
        layer.cornerRadius = 20
        anchor(width: 110)
    }

    private func setupLabelTextAndBackgroundColor(type: String) {
        text = type
        let typeColor = PokemonType(rawValue: type)?.color
        backgroundColor = typeColor
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
