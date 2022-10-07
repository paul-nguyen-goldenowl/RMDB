//
//  Constants.swift
//  RMDB
//
//  Created by Golden Owl on 06/10/2022.
//

import Foundation
import UIKit

struct K {

    // https://api.themoviedb.org/3/movie/popular?api_key=fb1d7b5f0bd8e62011e556c7da9d9bbd&language=en-US&page=1
    // https://api.themoviedb.org/3/movie/760161?api_key=fb1d7b5f0bd8e62011e556c7da9d9bbd&language=en-US
    // https://api.themoviedb.org/3/movie/718930/credits?api_key=fb1d7b5f0bd8e62011e556c7da9d9bbd
    
    // https://image.tmdb.org/t/p/w500/tVxDe01Zy3kZqaZRNiXFGDICdZk.jpg
    enum API {
        static let URL = "https://api.themoviedb.org/3/movie/"
        static let imageUrlBase = "https://image.tmdb.org/t/p/w500/"
        static let apiKey = "fb1d7b5f0bd8e62011e556c7da9d9bbd"
        static let language = "en-US"
        static let page = 1
        static var params: [String: Any] = ["api_key": apiKey,
                                            "language": language,
                                            "page": page]
    }
    
    enum Images {
        static let backgroundImage = UIImage(systemName: "person")
        static let close = UIImage(systemName: "xmark.circle")
    }
    
    enum Font{
        static let titleFont = UIFont.systemFont(ofSize: 25, weight: .black)
    }
}
