//
//  SpecificPokemoninfoViewController.swift
//  Pokemondex
//
//  Created by Rin on 2021/09/19.
//

import UIKit

final class SpecificPokemoninfoViewController: UIViewController {

    //MARK: - Propaties
    var pokemon: Pokemon?

    //MARK: - Views
    private let monsterBallImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "モンスターボール")
        imageView.frame.size = CGSize(width: 50, height: 50)
        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = pokemon?.name
        label.font = .systemFont(ofSize: 25, weight: .regular)
        label.textColor = .black
        label.backgroundColor = UIColor.rgb(red: 255, green: 248, blue: 220)
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        return label
    }()

    private let underLabelShadowView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: 8, height: 8)
        view.layer.shadowOpacity = 0.4
        view.layer.shadowRadius = 10
        return view
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "モンスターボール")
        return imageView
    }()
    let bottomControlView = UIView()

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }

    private func setupLayout() {
        view.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = .white

        underLabelShadowView.addSubview(nameLabel)
        view.addSubview(underLabelShadowView)
        view.addSubview(monsterBallImage)
        nameLabel.anchor(top: view.topAnchor, centerX: view.centerXAnchor ,width: UIScreen.main.bounds.width * 0.5, height: 35, topPadding: UIScreen.main.bounds.height * 0.15)
        underLabelShadowView.anchor(top: view.topAnchor, centerX: view.centerXAnchor ,width: UIScreen.main.bounds.width * 0.5, height: 35, topPadding: UIScreen.main.bounds.height * 0.15)
        monsterBallImage.anchor(centerY: nameLabel.centerYAnchor, centerX: nameLabel.leftAnchor, width: 50, height: 50)

    }
}
