//
//  Character.swift
//  BobsBurgers
//
//  Created by Ilya Zemskov on 28.03.2023.
//

import Foundation

struct Character: Decodable {
    let image: String
    let gender: String
    let hairColor: String
    let occupation: String
    let firstEpisode: String
    let voicedBy: String
    let moreInfo: String
}
