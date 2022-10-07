//
//  ViewController.swift
//  RMDB
//
//  Created by Golden Owl on 06/10/2022.
//

import UIKit

class MainViewController: UIViewController {
    lazy var collectionView: UICollectionView = {
        let numberOfItemsInSection = 2
        
        let spacing = CGFloat(20)
        let headerHeight = CGFloat(4)

        let layout = UICollectionViewFlowLayout()
        
        let totalSpace = spacing * CGFloat(numberOfItemsInSection + 1)
        let itemWidth = CGFloat((view.bounds.width - totalSpace) / CGFloat(numberOfItemsInSection))
        let itemHeight = itemWidth * 1.7
        
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.headerReferenceSize = CGSize(width: view.frame.size.width, height: headerHeight)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.register(MainCell.self, forCellWithReuseIdentifier: MainCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    lazy var loadingView = {
        let view = LoadingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        fetchPopular()
    }
    
    // MARK: - Private methods

    private func setupLayout() {
        view.backgroundColor = .blue
        
        configureNavigation()
        [collectionView, loadingView].forEach {
            view.addSubview($0)
        }
        
        loadingView.frame = view.bounds
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func showLoading() {
        loadingView.isHidden = false
    }
    
    private func hideLoading() {
        loadingView.isHidden = true
    }
    
    private func configureNavigation() {}
    
    private func fetchPopular() {
        viewModel.fetchPopular(completion: { [weak self] result in
            switch result {
            case .success:
                print("fetch data success")
                self?.collectionView.reloadData()
            case let .failure(error):
                self?.showErrorNotification(error: error)
            }
        })
    }

    private func showErrorNotification(error: NetworkError) {
        print("Error=\(error.errorDescription)")
    }
}

// MARK: - CollectionView

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: MainCell.identifier, for: indexPath) as? MainCell ?? MainCell()

        let movie = viewModel.movies[indexPath.row]
        cell.bindView(with: movie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.navigateWithMovie(self, movie: viewModel.movies[indexPath.row])
    }
}
