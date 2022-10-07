//
//  MainViewController.swift
//  RMDB
//
//  Created by Golden Owl on 06/10/2022.
//

import UIKit

class MainViewModel {
    var movies: [MovieWithLike]
    var error: NetworkError?

    init() {
        movies = []
        error = nil
    }

    func fetchPopular(completion: @escaping CompletionClosure) {
        NetworkManager.shared.fetchPopular(completion: { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case let .success(result):
                    self.movies = result.map { movie in
                        MovieWithLike(movie: movie, isLike: false)
                    }
                    completion(.success(result))
                case let .failure(error):
                    self.error = error
                    completion(.failure(error))
                }
            }
        })
    }

    func navigateWithMovie(_ vc: UIViewController, movie: Movie) {
        let viewController = DetailViewController()
        let detailViewModel = viewController.viewModel
        detailViewModel.movie = movie
        let navController = UINavigationController(rootViewController: viewController)
        navController.modalPresentationStyle = .fullScreen
        vc.navigationController?.present(navController, animated: true)
    }
}
