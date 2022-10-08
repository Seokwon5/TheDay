//
//  Feed.swift
//  TheDay
//
//  Created by 이석원 on 2022/10/08.
//

import Foundation

struct Feed: Decodable {
    let title: String 
    let description: String
    let imageURL: String
}
