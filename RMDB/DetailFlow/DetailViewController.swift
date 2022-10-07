//
//  DetailViewController.swift
//  RMDB
//
//  Created by Golden Owl on 07/10/2022.
//

import UIKit

class DetailViewController: UIViewController {
    // MARK: - Views
        
    private lazy var movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 30
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        label.sizeToFit()
        label.numberOfLines = 12
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.blue.cgColor,
        ]
        gradientLayer.locations = [0.3, 1.0]
        return gradientLayer
    }()
      
    private lazy var loadingView: LoadingView = {
        let loadingView = LoadingView()
        loadingView.layer.zPosition = 999
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        return loadingView
    }()
    
    private lazy var tableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.layer.cornerRadius = 10
        tableView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(DetailCell.self, forCellReuseIdentifier: DetailCell.identifier)
        tableView.rowHeight = view.frame.size.width * 1.5
        return tableView
    }()
    
    let viewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeViewModel()
        setupLayout()
        loadMovieCharactor()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        gradientLayer.frame = movieImage.bounds
        movieImage.layer.addSublayer(gradientLayer)
    }

    // MARK: - Private method

    private func subscribeViewModel(){
        viewModel.delegate = self
    }
    
    private func setupLayout() {
        configureNavigation()
        view.backgroundColor = .white
        [movieImage, detailLabel, loadingView, tableView].forEach {
            view.addSubview($0)
        }
        NSLayoutConstraint.activate([
            movieImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95),
            movieImage.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            movieImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            movieImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            detailLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.92),
            detailLabel.bottomAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: -10),
            detailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: movieImage.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        loadMovieDetail()
    }
    
    private func configureNavigation() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: K.Images.close, style: .done, target: self, action: #selector(didTapBack))
        navigationController?.navigationBar.barTintColor = .white
        let attributes = [
            NSAttributedString.Key.font: K.Font.titleFont ?? UIFont.systemFont(ofSize: 30, weight: .black),
        ]
        UINavigationBar.appearance().titleTextAttributes = attributes
    }
    
    @objc func didTapBack() {
        dismiss(animated: true)
    }
    
    private func loadMovieDetail() {
        if let poster = viewModel.movie?.poster {
            movieImage.loadUrl(string: Movie.getImageUrl(from: poster))
        }
        navigationController?.navigationBar.topItem?.title = viewModel.movie?.title
        detailLabel.text = viewModel.movie?.overview
    }

    
    private func loadMovieCharactor() {
        if let id = viewModel.movie?.id {
            viewModel.loadMovieCharactor(by: id)
        }
    }

    private func showLoadingView() {
        loadingView.isHidden = false
    }
       
    private func hideLoadingView() {
        DispatchQueue.main.async {
            self.loadingView.isHidden = true
        }
    }
}

extension DetailViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.charactors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: DetailCell.identifier, for: indexPath)
        if let cell = cell as? DetailCell {
            let charactor = viewModel.charactors[indexPath.row]
            cell.bindView(with: charactor)
        }
        return cell
    }
    
    
}

extension DetailViewController: DetailViewModelDelegate{
    func onFetchCharactorsSuccess() {
        print("success \(viewModel.charactors)")
        self.tableView.reloadData()
        hideLoadingView()
    }
    
    func onFetchCharactorsFailure(error: NetworkError) {
        print("Error: \(error.errorDescription)")
        // TODO: - notify
    }
}
