//
//  MainCell.swift
//  RMDB
//
//  Created by Golden Owl on 06/10/2022.
//

import UIKit

class MainCell: BaseUICollectionViewCell {
    
    static let identifier = "main_cell"
    
    lazy var imageView : UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func setupLayout() {
        [imageView].forEach {
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    func bindView(with data: Movie){
        let url = K.API.imageUrlBase + data.poster
        imageView.loadUrl(string: url)
    }
}
