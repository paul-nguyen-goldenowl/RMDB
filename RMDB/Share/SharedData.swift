//
//  SharedData.swift
//  RMDB
//
//  Created by Golden Owl on 07/10/2022.
//

import Foundation

class SharedData {
    static let shared = SharedData()
    private init(){}
    
    var likedVideos = Set<Int>()
}
