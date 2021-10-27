//
//  AdoptiOS15Protocol.swift
//  Pokemondex
//
//  Created by Rin on 2021/10/16.
//

import Foundation
import UIKit

protocol AdoptNewiOSVersionProtocol {
    func navigationbarAdoptToiOS15()
}

extension AdoptNewiOSVersionProtocol where Self: UIViewController {
    func navigationbarAdoptToiOS15() {
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.backgroundColor = .systemPink
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        } else {
            navigationController?.navigationBar.barTintColor = .systemPink
        }
    }
}
