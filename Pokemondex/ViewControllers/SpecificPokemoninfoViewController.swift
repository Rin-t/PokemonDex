//
//  SpecificPokemoninfoViewController.swift
//  Pokemondex
//
//  Created by Rin on 2021/09/19.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage

final class SpecificPokemoninfoViewController: UIViewController {

    //MARK: - Propaties
    var pokemon: Pokemon?
    private let disposeBag = DisposeBag()

    //MARK: - Views
    private lazy var nameLabel = PokemonIdLabel(pokemonId: pokemon?.id)
    private lazy var pokemonView = PokemonView(pokemon: pokemon)
    private let underLabelShadowView = ShadowView()
    private let monsterBallImage = PokemonImageView()
    private let bottomControlView = BottomButtonsView()

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupBindings()
    }

    private func setupLayout() {
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .white

        underLabelShadowView.addSubview(nameLabel)
        view.addSubview(underLabelShadowView)
        view.addSubview(monsterBallImage)
        view.addSubview(pokemonView)
        view.addSubview(bottomControlView)

        nameLabel.anchor(top: view.topAnchor, centerX: view.centerXAnchor ,width: UIScreen.main.bounds.width * 0.5, height: 35, topPadding: UIScreen.main.bounds.height * 0.15)
        underLabelShadowView.anchor(top: view.topAnchor, centerX: view.centerXAnchor ,width: UIScreen.main.bounds.width * 0.5, height: 35, topPadding: UIScreen.main.bounds.height * 0.15)
        monsterBallImage.anchor(centerY: nameLabel.centerYAnchor, centerX: nameLabel.leftAnchor, width: 50, height: 50)
        pokemonView.anchor(top: nameLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 500, topPadding: 40, leftPadding: 20, rightPadding: 20)
        bottomControlView.anchor(top: pokemonView.bottomAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, topPadding: 20)

    }

    private func setupBindings() {

        let nomalImage = URL(string: pokemon?.sprites.frontImage ?? "")
        let shinyImage = URL(string: pokemon?.sprites.shinyImage ?? "")

        bottomControlView.nomalColorButton.button?.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                self?.pokemonView.imageView.sd_setImage(with: nomalImage)
            }
            .disposed(by: disposeBag)

        bottomControlView.shinyColorButton.button?.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                self?.pokemonView.imageView.sd_setImage(with: shinyImage)
            }
            .disposed(by: disposeBag)

    
    }
}
