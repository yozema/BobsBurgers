//
//  CharacterCell.swift
//  BobsBurgers
//
//  Created by Ilya Zemskov on 28.03.2023.
//

import UIKit

final class PersonCell: UICollectionViewCell {
    // MARK: - IBOutlets
    @IBOutlet var personImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var occupationNameLabel: UILabel!
    @IBOutlet var occupationLabel: UILabel!
    
    // MARK: - Properties
    private let networkManager = NetworkManager.shared
    
    // MARK: - Cell Configuration
    func configure(with person: Person) {
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        nameLabel.text = person.name
        occupationNameLabel.text = person.occupation
        occupationLabel.text = person.occupation.contains("Student")
        ? "🎒" 
        : "💼"
        
        networkManager.fetchData(from: URL(string: person.image)!) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.personImage.image = UIImage(data: imageData)
                self?.activityIndicator.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
    }
}
