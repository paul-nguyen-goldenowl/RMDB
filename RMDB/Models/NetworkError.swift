//
//  NetworkError.swift
//  RMDB
//
//  Created by Golden Owl on 06/10/2022.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case badURL, badJSON, serverError

    var errorDescription: String {
        switch self {
        case .badURL:
            return "Invalid URL."
        case .badJSON:
            return "Can't load data."
        case .serverError:
            return "Server not responding."
        }
    }
}
