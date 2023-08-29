//
//  AdDetailsView.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/28/23.
//

import UIKit

final class AdDetailsView: UIView {
    
    // MARK: - Private Properties
    
    private var advertisementDetail: AdvertisementDetail? {
        didSet {
            guard let ad = advertisementDetail else { return }
            titleLabel.text = ad.title
            priceLabel.text = ad.formattedPrice
            locationLabel.text = ad.location + ", " + ad.address
            createdDateLabel.text = ad.formattedCreatedDate
            descriptionTextView.text = ad.description
            emailLabel.text = ad.email
            phoneNumberLabel.text = ad.phoneNumber
        }
    }
    
    // MARK: - Private UI Properties
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .equalCentering
        stackView.spacing = 10
        return stackView
    }()
    
    private let imageView = AdImageView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = AppFonts.Details.title
        label.textColor = AppColors.label
        label.numberOfLines = 0
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = AppFonts.Details.price
        label.textColor = AppColors.label
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = AppFonts.Details.descriptionStaticLabel
        label.textColor = AppColors.label
        label.text = AppData.descriptionLabelText
        return label
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.font = AppFonts.Details.description
        textView.textColor = AppColors.label
        return textView
    }()
    
    // MARK: Location
    
    private let locationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = AppIcons.location
        return imageView
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = AppFonts.Details.location
        label.textColor = AppColors.label
        return label
    }()
    
    private lazy var locationImageLabelView = ImageLabelView(imageView: locationImageView, label: locationLabel)
    
    // MARK: Date
    
    private let calendarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = AppIcons.calendar
        return imageView
    }()
    
    private let createdDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = AppFonts.Details.createdDate
        label.textColor = AppColors.label
        return label
    }()
    
    private lazy var dateImageLabelView = ImageLabelView(imageView: calendarImageView, label: createdDateLabel)
    
    // MARK: Email
    
    private let mailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = AppIcons.mail
        return imageView
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = AppFonts.Details.email
        label.textColor = AppColors.label
        return label
    }()
    
    private lazy var emailImageLabelView = ImageLabelView(imageView: mailImageView, label: emailLabel)
    
    // MARK: Phone
    
    private let phoneImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = AppIcons.phone
        return imageView
    }()
    
    private let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = AppFonts.Details.phone
        label.textColor = AppColors.label
        return label
    }()
    
    private lazy var phoneImageLabelView = ImageLabelView(imageView: phoneImageView, label: phoneNumberLabel)
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal Methods
    
    func configure(image: UIImage?, adDetailModel: AdvertisementDetail) {
        if let image {
            imageView.image = image
            advertisementDetail = adDetailModel
        }
    }
}

// MARK: - Setup Layout, Constraints

private extension AdDetailsView {
    func setupLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        stackView.addArrangedSubviews(
            imageView,
            priceLabel,
            titleLabel,
            descriptionLabel,
            descriptionTextView,
            locationImageLabelView,
            dateImageLabelView,
            emailImageLabelView,
            phoneImageLabelView
        )
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
