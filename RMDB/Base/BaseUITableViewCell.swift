//
//  BaseUITableViewCell.swift
//  RMDB
//
//  Created by Golden Owl on 07/10/2022.
//

import UIKit

class BaseUITableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func setupLayout() {}
}
