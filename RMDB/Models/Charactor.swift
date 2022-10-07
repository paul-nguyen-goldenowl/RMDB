//
//  Charactor.swift
//  RMDB
//
//  Created by Golden Owl on 07/10/2022.
//

import Foundation

struct CharactorsData: Decodable {
    let id: Int
    let cast: [Charactor]
}

struct Charactor: Decodable {
    let name: String
    let avatar: String
    let popularity: Float

    enum CodingKeys: String, CodingKey {
        case name
        case avatar = "profile_path"
        case popularity
    }

//    id    718930
//    cast
//        0
//            adult    false
//            gender    2
//            id    287
//            known_for_department    "Acting"
//            name    "Brad Pitt"
//            original_name    "Brad Pitt"
//            popularity    86.614
//            profile_path    "/ajNaPmXVVMJFg9GWmu6MJzTaXdV.jpg"
//            cast_id    3
//            character    "Ladybug"
//            credit_id    "5f03b34e5545ca0036d8294e"
//            order    0
}
