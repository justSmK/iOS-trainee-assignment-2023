//
//  AdvertisementCollectionViewCell.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/26/23.
//

import UIKit

class AdvertisementCollectionViewCell: UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: AdvertisementCollectionViewCell.self)
    }
    
    var currentId: String?
    
    private var advertisement: Advertisement? {
        didSet {
            guard let ad = advertisement else { return }
            titleLabel.text = ad.title
            priceLabel.text = ad.price
            locationLabel.text = ad.location
            createdDateLabel.text = ad.formattedCreatedDate
        }
    }
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 12
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = AppFonts.title
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = AppFonts.price
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = AppFonts.location
        return label
    }()
    
    private let createdDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = AppFonts.createdDate
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        advertisement = nil
        imageView.image = nil
    }
    
    func configure(image: UIImage?, advertisementModel: Advertisement) {
        if let image {
            imageView.image = image
            advertisement = advertisementModel
            activityIndicator.stopAnimating()
        } else {
            activityIndicator.startAnimating()
        }
    }
}


private extension AdvertisementCollectionViewCell {
    func setupLayout() {
        
        contentView.addSubviews(
            activityIndicator,
            imageView,
            titleLabel,
            priceLabel,
            locationLabel,
            createdDateLabel
        )
        
        activityIndicator.center = contentView.center

//        contentView.backgroundColor = .yellow
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
            createdDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
