//
//  AdvertisementCollectionViewCell.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/26/23.
//

import UIKit

final class AdvertisementCollectionViewCell: UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: AdvertisementCollectionViewCell.self)
    }
    
    var currentId: String?
    
    // MARK: - Private Properties
    
    private var advertisement: Advertisement? {
        didSet {
            guard let ad = advertisement else { return }
            titleLabel.text = ad.title
            priceLabel.text = ad.formattedPrice
            locationLabel.text = ad.location
            createdDateLabel.text = ad.formattedCreatedDate
        }
    }
    
    // MARK: UI
    
    private let loadingView = LoadingView()
    
    private let imageView = AdImageView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = AppFonts.Cell.title
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = AppFonts.Cell.price
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = AppFonts.Cell.location
        return label
    }()
    
    private let createdDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = AppFonts.Cell.createdDate
        return label
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        advertisement = nil
        imageView.image = nil
    }
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupConstraints()
        setupLoadingView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal Methods
    
    func configure(image: UIImage?, advertisementModel: Advertisement) {
        if let image {
            imageView.image = image
            advertisement = advertisementModel
            loadingView.stopAnimating()
        } else {
            loadingView.startAnimating()
        }
    }
}

// MARK: - Setup Layout, Constraints

private extension AdvertisementCollectionViewCell {
    func setupLayout() {
        contentView.addSubviews(
            imageView,
            titleLabel,
            priceLabel,
            locationLabel,
            createdDateLabel
        )
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            locationLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            locationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            createdDateLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor),
            createdDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            createdDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    func setupLoadingView() {
        loadingView.startAnimating()
        contentView.addSubview(loadingView)
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
}
