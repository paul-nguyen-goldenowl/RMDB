//
//  MainCell.swift
//  RMDB
//
//  Created by Golden Owl on 06/10/2022.
//

import UIKit

class MainCell: BaseUICollectionViewCell {
    
    static let identifier = "main_cell"
    
    var didTapLikeAction: (() -> Void)?
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var likeButton = {
        let button = UIButton()
        button.setImage(K.Images.like, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func setupLayout() {
        [imageView, likeButton].forEach {
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            likeButton.widthAnchor.constraint(equalToConstant: 30),
            likeButton.heightAnchor.constraint(equalToConstant: 30),
            likeButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -10),
            likeButton.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -10)
        ])
    }
    
    func bindView(with movie: MovieWithLike) {
        let data = movie.movie
        print("bind view \(movie.movie.title) like:\(movie.isLike)")
        let url = K.API.imageUrlBase + data.poster
        imageView.loadUrl(string: url)
        likeButton.tag = data.id
        likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
        
        if movie.isLike {
            likeButton.setImage(K.Images.liked, for: .normal)
        } else {
            likeButton.setImage(K.Images.like, for: .normal)
        }
    }
    
    @objc private func didTapLikeButton() {
        didTapLikeAction?()
    }
    
    func updateLikeState(isLike: Bool){
        if isLike {
            likeButton.setImage(K.Images.liked, for: .normal)
        } else {
            likeButton.setImage(K.Images.like, for: .normal)
        }
    }
}
