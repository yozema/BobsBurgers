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
    @IBOutlet var personLabel: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    private let networkManager = NetworkManager.shared
    
    // MARK: - Cell Configuration
    func configure(with person: Person) {
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        personLabel.text = person.shortDescription
        
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
