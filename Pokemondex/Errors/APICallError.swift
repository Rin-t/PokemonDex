//
//  APICallError.swift
//  Pokemondex
//
//  Created by Rin on 2021/10/18.
//

import Foundation

enum APICallError: Error {
    case unconvertibleToURL
    case failToFetchData

    var title: String {
        switch self {
        case .unconvertibleToURL:
            return "変換不可"
        case .failToFetchData:
            return "通信の失敗"
        }
    }

    var message: String {
        switch self {
        case .unconvertibleToURL:
            return "URLに変換することができませんでした。"
        case .failToFetchData:
            return "データの通信に失敗しました。通信状況の良い場所で使用してください。"
        }
    }
}
