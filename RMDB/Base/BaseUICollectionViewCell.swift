//
//  BaseUICollectionViewCell.swift
//  RMDB
//
//  Created by Golden Owl on 06/10/2022.
//

import UIKit

class BaseUICollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setupLayout(){}
}
