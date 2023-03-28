//
//  Character.swift
//  BobsBurgers
//
//  Created by Ilya Zemskov on 28.03.2023.
//

import Foundation

struct Person: Decodable {
    let name: String
    let image: String
    let gender: String
    let hairColor: String
    let occupation: String
    let firstEpisode: String
    let voicedBy: String
    let moreInfo: String
    
    var shortDescription: String {
        """
        👤 \(name)
        💼 \(occupation)
        """
    }
    
    var description: String {
        """
        Name: \(name)
        Gender: \(gender)
        Hair Color: \(hairColor)
        Occupation: \(occupation)
        First Episode: \(firstEpisode)
        Voiced By: \(voicedBy)
        More Info: \(moreInfo)
        """
    }
    
    init(
        name: String,
        image: String,
        gender: String,
        hairColor: String,
        occupation: String,
        firstEpisode: String,
        voicedBy: String,
        moreInfo: String
    )
    {
        self.name = name
        self.image = image
        self.gender = gender
        self.hairColor = hairColor
        self.occupation = occupation
        self.firstEpisode = firstEpisode
        self.voicedBy = voicedBy
        self.moreInfo = moreInfo
    }
    
    init(personData: [String: Any]) {
        name = personData["name"] as? String ?? ""
        image = personData["image"] as? String ?? ""
        gender = personData["gender"] as? String ?? ""
        hairColor = personData["hairColor"] as? String ?? ""
        occupation = personData["occupation"] as? String ?? "Unknown"
        firstEpisode = personData["firstEpisode"] as? String ?? ""
        voicedBy = personData["voicedBy"] as? String ?? ""
        moreInfo = personData["moreInfo"] as? String ?? ""
    }
    
    static func getPersons(from value: Any) -> [Person] {
        guard let personsData = value as? [[String: Any]] else { return [] }
        return personsData.map { Person(personData: $0) }
    }
}
