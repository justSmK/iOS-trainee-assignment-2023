//
//  AdvertisementsCollectionView.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/24/23.
//

import UIKit

final class AdvertisementCollectionView: UICollectionView {
    
    private let layout = UICollectionViewFlowLayout()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setupLayout()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension AdvertisementCollectionView {
    func setupLayout() {
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
        ])
    }
}
