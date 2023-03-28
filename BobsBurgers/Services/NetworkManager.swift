//
//  NetworkManager.swift
//  BobsBurgers
//
//  Created by Ilya Zemskov on 28.03.2023.
//

import Foundation
import Alamofire

enum Link {
    case BobsBurgers
    
    var url: URL {
        switch self {
        case .BobsBurgers:
            return URL(string: "https://bobsburgers-api.herokuapp.com/characters/")!
        }
    }
}

final class NetworkManager {
    
}
