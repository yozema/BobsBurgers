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
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchPersons(from url: URL, completion: @escaping(Result<[Person], AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let persons = Person.getPersons(from: value)
                    completion(.success(persons))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

    func fetchData(from url: URL, completion: @escaping(Result<Data, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { dataResponse in
                switch dataResponse.result {
                case .success(let imageData):
                    completion(.success(imageData))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
