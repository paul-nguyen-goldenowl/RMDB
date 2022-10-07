//
//  Movie.swift
//  RMDB
//  Created by Golden Owl on 06/10/2022.
//

import Foundation

struct MovieData: Decodable {
    let page: Int
    let results: [Movie]
}

struct Movie: Codable {
    let id: Int
    let backdrop: String
    let title: String
    let overview: String
    let poster: String

    enum CodingKeys: String, CodingKey {
        case id
        case backdrop = "backdrop_path"
        case title
        case overview
        case poster = "poster_path"
    }

    static func getImageUrl(from path: String) -> String {
        return K.API.imageUrlBase + path
    }

//    adult    false
//    backdrop_path    "/y2Ca1neKke2mGPMaHzlCNDVZqsK.jpg"
//    genre_ids    […]
//    id    718930
//    original_language    "en"
//    original_title    "Bullet Train"
//    overview    "Unlucky assassin Ladybug is determined to do his job peacefully after one too many gigs gone off the rails. Fate, however, may have other plans, as Ladybug's latest mission puts him on a collision course with lethal adversaries from around the globe—all with connected, yet conflicting, objectives—on the world's fastest train."
//    popularity    5159.444
//    poster_path    "/tVxDe01Zy3kZqaZRNiXFGDICdZk.jpg"
//    release_date    "2022-07-03"
//    title    "Bullet Train"
//    video    false
//    vote_average    7.5
//    vote_count    1407
}
