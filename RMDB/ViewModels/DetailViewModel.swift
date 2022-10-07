//
//  DetailViewModel.swift
//  RMDB
//
//  Created by Golden Owl on 07/10/2022.
//
import UIKit

protocol DetailViewModelDelegate: AnyObject {
    func onFetchCharactorsSuccess()
    func onFetchCharactorsFailure(error: NetworkError)
}

class DetailViewModel {
    var movie: Movie?
    var charactors: [Charactor] = []

    weak var delegate: DetailViewModelDelegate?

    func loadMovieCharactor(by id: Int) {
        print("loadMovieCharactor...")
        NetworkManager.shared.loadMovieCharactor(by: id, completion: { [weak self] result in
            switch result {
            case let .failure(error):
                self?.delegate?.onFetchCharactorsFailure(error: error)
            case let .success(data):
                self?.charactors = data
                self?.delegate?.onFetchCharactorsSuccess()
            }
        })
    }
}
