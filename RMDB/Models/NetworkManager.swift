//
//  NetworkManager.swift
//  RMDB
//
//  Created by Golden Owl on 06/10/2022.
//

import Alamofire
import Foundation

typealias CompletionClosure = (Result<[Movie], NetworkError>) -> Void
typealias CharactorCompletion = (Result<[Charactor], NetworkError>) -> Void

class NetworkManager {
    static let shared = NetworkManager()

    func fetchPopular(completion: @escaping CompletionClosure) {
        let url = K.API.URL + "popular"
        let params = K.API.params

        AF.sessionConfiguration.timeoutIntervalForRequest = 10
        AF.request(url, method: .get, parameters: params, encoding: URLEncoding.default)
            .validate(statusCode: 200 ..< 299)
            .validate(contentType: ["application/json"])
            .responseData { responseData in
                guard let response = responseData.response
                else { return completion(.failure(.serverError)) }
                if response.statusCode >= 300 {
                    completion(.failure(.badURL))
                }
            }
            .responseDecodable(of: MovieData.self, completionHandler: { response in
                guard let movies = response.value?.results else {
                    return completion(.failure(.badURL))
                }
                completion(.success(movies))
            })
    }

    func loadMovieCharactor(by id: Int, completion: @escaping CharactorCompletion) {
        let url = K.API.URL + "\(id)/credits"
        let param = ["api_key": K.API.apiKey]

        AF.sessionConfiguration.timeoutIntervalForRequest = 10
        AF.request(url, method: .get, parameters: param, encoding: URLEncoding.default)
            .validate(statusCode: 200 ..< 299)
            .validate(contentType: ["application/json"])
            .responseData { responseData in
                guard let response = responseData.response
                else {
                    return completion(.failure(.serverError))
                }
                if response.statusCode >= 300 {
                    completion(.failure(.badURL))
                }
            }
            .responseDecodable(of: CharactorsData.self) {
                response in
                guard let charactors = response.value?.cast else {
                    return completion(.failure(.badJSON))
                }
                completion(.success(charactors))
            }
    }
}
