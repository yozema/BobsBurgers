//
//  CharacterDescriptionViewController.swift
//  BobsBurgers
//
//  Created by Ilya Zemskov on 28.03.2023.
//

import UIKit

final class PersonDescriptionViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var personImage: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    var person: Person!
    private var networkManager = NetworkManager.shared
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        descriptionLabel.text = person.description
        title = person.name
        fetchImage()
    }
    
    // MARK: - Private Function
    private func fetchImage() {
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
