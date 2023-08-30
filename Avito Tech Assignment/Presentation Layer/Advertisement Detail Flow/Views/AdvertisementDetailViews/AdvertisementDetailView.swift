//
//  AdvertisementDetailView.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/28/23.
//

import UIKit

final class AdvertisementDetailView: UIView {
    
    weak var delegate: AdvertisementsErrorViewDelegate?
    
    // MARK: - Private Properties
    
    private let loadingView: LoadingViewProtocol = LoadingView()
    
    private let adDetailsView = AdDetailsView()
    
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
    
    func showLoading() {
        adDetailsView.isHidden = true
        loadingView.startAnimating()
    }
    
    func showPresentStateConfigure(image: UIImage?, adDetailModel: AdvertisementDetail) {
        adDetailsView.isHidden = false
        loadingView.stopAnimating()
        adDetailsView.configure(image: image, adDetailModel: adDetailModel)
    }
    
    func showErrorState(message: String) {
        adDetailsView.isHidden = true
        loadingView.stopAnimating()
        delegate?.showErrorAlert(message: message)
    }
}

// MARK: - Setup Layout, Constraints

private extension AdvertisementDetailView {
    func setupLayout() {
        self.backgroundColor = AppColors.background
        addSubview(adDetailsView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            adDetailsView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            adDetailsView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            adDetailsView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            adDetailsView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0),
        ])
    }
    
    func setupLoadingView() {
        addSubview(loadingView)
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
}

