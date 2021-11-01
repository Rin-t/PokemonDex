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
    private var pokemon: Pokemon!
    private let disposeBag = DisposeBag()

    static func instantiate(pokemon: Pokemon) -> SpecificPokemoninfoViewController {
        let vc = SpecificPokemoninfoViewController()
        vc.pokemon = pokemon
        return vc
    }

    //MARK: - Views
    private lazy var pokemonIdLabel: PokemonIdLabel = {
        let label = PokemonIdLabel(pokemonId: pokemon.id)
        label.accessibilityIdentifier = "pokemonIdLabel"
        return label
    }()

    private lazy var pokemonView: PokemonView = {
        let label = PokemonView(pokemon: pokemon)
        label.accessibilityIdentifier = "pokemonView"
        return label
    }()

    private let underIdLabelShadowView: ShadowView = {
        let view = ShadowView()
        view.accessibilityIdentifier = "underIdLabelShadowView"
        return view
    }()
    private let monsterBallImage: MonsterBallImageView = {
        let imageView = MonsterBallImageView()
        imageView.accessibilityIdentifier = "monsterBallImage"
        return imageView
    }()
    private let bottomButtonsView: BottomButtonsView = {
        let view = BottomButtonsView()
        view.accessibilityIdentifier = "bottomButtonsView"
        return view
    }()

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupBindings()
    }

    private func setupLayout() {
        let viewHeight = view.bounds.height
        let viewWidth = view.bounds.width
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .white

        underIdLabelShadowView.addSubview(pokemonIdLabel)
        view.addSubview(underIdLabelShadowView)
        view.addSubview(monsterBallImage)
        view.addSubview(pokemonView)
        view.addSubview(bottomButtonsView)

        pokemonIdLabel.anchor(top: view.topAnchor, centerX: view.centerXAnchor, width: viewWidth * 0.5, height: 35, topPadding: viewHeight * 0.15)
        underIdLabelShadowView.anchor(top: view.topAnchor, centerX: view.centerXAnchor ,width: viewWidth * 0.5, height: 35, topPadding: viewHeight * 0.15)
        monsterBallImage.anchor(centerY: pokemonIdLabel.centerYAnchor, centerX: pokemonIdLabel.leftAnchor, width: 50, height: 50)
        pokemonView.anchor(top: pokemonIdLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, height: viewHeight * 0.6, topPadding: viewWidth * 0.06, leftPadding: 20, rightPadding: 20)
        bottomButtonsView.anchor(top: pokemonView.bottomAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, topPadding: viewHeight * 0.03, bottomPadding: viewHeight * 0.05)
    }

    private func setupBindings() {

        let nomalImageURL = URL(string: pokemon.sprites.frontImage)
        let shinyImageURL = URL(string: pokemon.sprites.shinyImage)

        bottomButtonsView.nomalColorButton.button?.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                self?.pokemonView.imageView.sd_setImage(with: nomalImageURL)
            }
            .disposed(by: disposeBag)

        bottomButtonsView.shinyColorButton.button?.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                self?.pokemonView.imageView.sd_setImage(with: shinyImageURL)
            }
            .disposed(by: disposeBag)

    }
}
