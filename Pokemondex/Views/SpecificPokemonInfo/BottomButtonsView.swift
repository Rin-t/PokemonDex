//
//  BottomButtonsView.swift
//  Pokemondex
//
//  Created by Rin on 2021/09/20.
//

import UIKit

import UIKit

final class BottomButtonsView: UIView {
    //MARK: - Propaties
    let nomalColorButton = BottomButtonView(frame: .zero, width: 100, buttonTitle: "nomal")
    let shinyColorButton = BottomButtonView(frame: .zero, width: 100, buttonTitle: "shiny")

    //MARK: - Methods
    init() {
        super.init(frame: .zero)
        let basestackView = UIStackView(arrangedSubviews: [nomalColorButton, shinyColorButton])
        basestackView.axis = .horizontal
        basestackView.distribution = .fillEqually
        basestackView.spacing = 10
        basestackView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(basestackView)
        basestackView.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, leftPadding: 10, rightPadding: 10)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder) 
    }
}

final class BottomButtonView: UIView {

    //MARK: - Propaties
    var button: BottomButton?
    private let screenHeight = UIScreen.main.bounds.height
    private let screenWidth = UIScreen.main.bounds.width

    //MARK: - Methods
    init(frame: CGRect, width: CGFloat, buttonTitle: String) {
        super.init(frame: frame)
        button = BottomButton(type: .custom)
        guard let button = button else { return }

        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.setTitle(buttonTitle, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 25, weight: .regular)
        button.backgroundColor = UIColor.rgb(red: 255, green: 248, blue: 220)
        button.layer.shadowOffset = .init(width: 1.5, height: 2)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowRadius = 15

        addSubview(button)

        button.anchor(centerY: centerYAnchor, centerX: centerXAnchor, width: screenWidth * 0.3, height: screenHeight * 0.08)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

final class BottomButton: UIButton {
    //MARK: - Methods
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.7, options: []) {
                    self.transform = .init(scaleX: 0.8, y: 0.8)
                    self.layoutIfNeeded()
                }
            } else {
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.7, options: []) {
                    self.transform = .identity
                    self.layoutIfNeeded()
                }
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

