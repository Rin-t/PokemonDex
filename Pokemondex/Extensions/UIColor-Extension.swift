//
//  UIColor-Extension.swift
//  Pokemondex
//
//  Created by Rin on 2021/09/18.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) -> UIColor {
        .init(red: red / 255, green: green / 255, blue: blue / 255, alpha: alpha)
    }
}
