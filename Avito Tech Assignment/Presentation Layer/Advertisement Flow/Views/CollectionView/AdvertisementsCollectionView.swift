//
//  AdvertisementsCollectionView.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/24/23.
//

import UIKit

final class AdvertisementCollectionView: UICollectionView {
    
    // MARK: - Private Properties
    
    private var isLayoutConfigured = false
    
    // MARK: - Initializers
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: UICollectionViewLayout())
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard !isLayoutConfigured else { return }
        
        let offset = AppConstants.space * 3 // left + middle min space + right
        let itemWidth = (self.bounds.width - offset) / 2
        let itemHeight = itemWidth + (self.bounds.height / 7)
        let layout = createCompositionalLayout(itemHeight: itemHeight, itemWidth: itemWidth)
        
        self.collectionViewLayout = layout
        isLayoutConfigured = true
    }
    
    private func createCompositionalLayout(itemHeight: CGFloat, itemWidth: CGFloat) -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(itemWidth),
            heightDimension: .absolute(itemHeight)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(itemHeight)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .flexible(AppConstants.space)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: AppConstants.space,
            leading: AppConstants.space,
            bottom: AppConstants.space,
            trailing: AppConstants.space
        )
        section.interGroupSpacing = AppConstants.space

        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
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
