//
//  ShadowView.swift
//  Pokemondex
//
//  Created by Rin on 2021/09/20.
//

import UIKit

final class ShadowView: UIView {
    //MARK: - Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 8, height: 8)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 10
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder) 
    }
}
