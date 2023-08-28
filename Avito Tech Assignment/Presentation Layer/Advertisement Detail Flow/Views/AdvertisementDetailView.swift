//
//  AdvertisementDetailView.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/28/23.
//

import UIKit

final class AdvertisementDetailView: UIView {
    
    enum State {
        case loading
        case present
        case error(String)
    }
    
    private let adDetailsView = AdDetailsView()
    
    private let loadingView = UIActivityIndicatorView()
    private let errorView = UILabel()
    
    var currentState: State = .loading {
        didSet {
            updateState()
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        setupConstraints()
        
        setupErrorView()
        setupLoadingView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(adDetailModel: AdvertisementDetail) {
        adDetailsView.configure(advertisementDetailModel: adDetailModel)
    }
    
    func configure(image: UIImage?) {
        adDetailsView.configure(image: image)
    }
    
    private func setupLoadingView() {
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(loadingView)
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    private func setupErrorView() {
        errorView.textColor = .red
        errorView.numberOfLines = 0
        errorView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(errorView)
        NSLayoutConstraint.activate([
            errorView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            errorView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            errorView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    private func updateState() {
        
        switch currentState {
            
        case .loading:
            loadingView.isHidden = false
//            advertisementCollectionView.isHidden = true
            loadingView.startAnimating()
        case .present:
            loadingView.isHidden = true
//            advertisementCollectionView.isHidden = false
            loadingView.stopAnimating()
        case .error(let message):
            loadingView.isHidden = true
//            advertisementCollectionView.isHidden = true
            loadingView.stopAnimating()
            errorView.text = message
        }
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
            adDetailsView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            adDetailsView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            adDetailsView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            adDetailsView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

