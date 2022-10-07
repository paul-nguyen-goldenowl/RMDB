//
//  MainViewController.swift
//  RMDB
//
//  Created by Golden Owl on 06/10/2022.
//

import UIKit

class MainViewModel {
    var movies: [Movie]
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
                    self.movies = result
                    completion(.success(result))
                case let .failure(error):
                    self.error = error
                    completion(.failure(error))
                }
            }
        })
    }


//    func produceCharacterToViewModel(_ vc: UIViewController, character: Character) {
//        let viewController = DetailViewController()
//        let detailViewModel = viewController.viewModel
//        detailViewModel.character = character
//        let navigationController = UINavigationController(rootViewController: viewController)
//        navigationController.modalPresentationStyle = .fullScreen
//        vc.navigationController?.present(navigationController, animated: true)
//    }
}
