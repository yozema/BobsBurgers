//
//  CharactersCollectionViewController.swift
//  BobsBurgers
//
//  Created by Ilya Zemskov on 28.03.2023.
//

import UIKit

final class PersonsCollectionViewController: UICollectionViewController {
    // MARK: - Properties
    private var persons: [Person] = []
    private var networkManager = NetworkManager.shared
    private var spinnerView = UIActivityIndicatorView()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showSpinner(in: view)
        fetchPersons()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let item = sender as? Person else { return }
        if segue.identifier == "showDetails" {
            guard let detailsVC = segue.destination as? PersonDescriptionViewController else { return }
            detailsVC.person = item
        }
    }
    
    // MARK: - Private Functions
    private func fetchPersons() {
        networkManager.fetchPersons(from: Link.BobsBurgers.url) { [weak self] result in
            switch result {
            case .success(let persons):
                self?.persons = persons
                self?.collectionView.reloadData()
                self?.spinnerView.stopAnimating()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func showSpinner(in view: UIView) {
        spinnerView = UIActivityIndicatorView(style: .large)
        spinnerView.color = .red
        spinnerView.startAnimating()
        spinnerView.center = view.center
        spinnerView.hidesWhenStopped = true
        
        view.addSubview(spinnerView)
    }
}

// MARK: - UICollectionViewDataSource
extension PersonsCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        persons.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "personCell", for: indexPath)
        guard let cell = cell as? PersonCell else { return UICollectionViewCell() }
        let character = persons[indexPath.item]
        cell.configure(with: character)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCharacter = persons[indexPath.item]
        performSegue(withIdentifier: "showDetails", sender: selectedCharacter)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension PersonsCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 30, height: 100)
    }
}
