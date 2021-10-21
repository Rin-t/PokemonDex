//
//  APICallError.swift
//  Pokemondex
//
//  Created by Rin on 2021/10/18.
//

import Foundation

enum APICallError: Error {
    case failToFetchData

    var title: String {
        switch self {
        case .failToFetchData:
            return "通信の失敗"
        }
    }

    var message: String {
        switch self {
        case .failToFetchData:
            return "データの通信に失敗しました。通信状況の良い場所で使用してください。"
        }
    }
}
