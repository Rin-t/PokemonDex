//
//  BottomButtonsView.swift
//  Pokemondex
//
//  Created by Rin on 2021/09/20.
//

import UIKit

import UIKit

final class BottomButtonsView: UIView {

    let nomalColorButton = BottomButtonView(frame: .zero, width: 100, buttonTitle: "nomal")
    let shinyColorButton = BottomButtonView(frame: .zero, width: 100, buttonTitle: "shiny")

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
        fatalError("init has been implemented")
    }

}

final class BottomButtonView: UIView {

    var button: BottomButton?
    private let screenHeight = UIScreen.main.bounds.height
    private let screenWidth = UIScreen.main.bounds.width

    init(frame: CGRect, width: CGFloat, buttonTitle: String) {
        super.init(frame: frame)
        button = BottomButton(type: .custom)
        button?.translatesAutoresizingMaskIntoConstraints = false
        button?.backgroundColor = .white
        button?.layer.cornerRadius = 10
        button?.setTitle(buttonTitle, for: .normal)
        button?.setTitleColor(.black, for: .normal)
        button?.layer.shadowOffset = .init(width: 1.5, height: 2)
        button?.layer.shadowColor = UIColor.black.cgColor
        button?.layer.shadowOpacity = 0.3
        button?.layer.shadowRadius = 15

        guard let button = button else { return }
        addSubview(button)

        button.anchor(centerY: centerYAnchor, centerX: centerXAnchor, width: screenWidth * 0.3, height: screenHeight * 0.08)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BottomButton: UIButton {

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
        fatalError("init(coder:) has not been implemented")
    }
}

