//
//  DetailCell.swift
//  RMDB
//
//  Created by Golden Owl on 07/10/2022.
//

import UIKit

class DetailCell: BaseUITableViewCell {
    static let identifier = "detail_cell"

    lazy var imageCharactor = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var nameLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var popularityLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func setupLayout() {
        super.setupLayout()
        [imageCharactor, nameLabel, popularityLabel].forEach {
            contentView.addSubview($0)
        }

        NSLayoutConstraint.activate([
            imageCharactor.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8),
            imageCharactor.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1.3),
            imageCharactor.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageCharactor.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.topAnchor.constraint(equalTo: imageCharactor.bottomAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            popularityLabel.bottomAnchor.constraint(equalTo: imageCharactor.bottomAnchor, constant: 30),
            popularityLabel.trailingAnchor.constraint(equalTo: imageCharactor.trailingAnchor, constant: 30),
        ])
    }

    func bindView(with charactor: Charactor) {
        imageCharactor.loadUrl(string: Movie.getImageUrl(from: charactor.avatar))
        nameLabel.text = charactor.name
        popularityLabel.text = String(charactor.popularity)
    }
}
