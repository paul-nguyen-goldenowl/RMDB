//
//  Extensions.swift
//  RMDB
//
//  Created by Golden Owl on 06/10/2022.
//

import UIKit
import Nuke

extension UIImageView {
    func loadUrl(string url: String) {
        if let url = URL(string: url) {
            let options = ImageLoadingOptions(
                placeholder: K.Images.backgroundImage,
                transition: .fadeIn(duration: 0.5)
            )
            Nuke.loadImage(with: url, options: options, into: self)
        }
    }
}
