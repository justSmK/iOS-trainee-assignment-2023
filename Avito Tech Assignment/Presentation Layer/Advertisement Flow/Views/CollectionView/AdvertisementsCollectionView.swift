//
//  AdvertisementsCollectionView.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/24/23.
//

import UIKit

final class AdvertisementCollectionView: UICollectionView {
    
    // MARK: - Private Properties
    
    private let flowLayout = UICollectionViewFlowLayout()
    
    // MARK: - Initializers
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: flowLayout)
        
        flowLayout.scrollDirection = .vertical
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal Methods
    
    func configure(dataSourceDelegate: AdvertisementCollectionViewProtocols) {
        self.dataSource = dataSourceDelegate
        self.delegate = dataSourceDelegate
    }
}

// MARK: - Setup Layout

private extension AdvertisementCollectionView {
    func setupLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.register(
            AdvertisementCollectionViewCell.self,
            forCellWithReuseIdentifier: AdvertisementCollectionViewCell.identifier
        )
    }
}
