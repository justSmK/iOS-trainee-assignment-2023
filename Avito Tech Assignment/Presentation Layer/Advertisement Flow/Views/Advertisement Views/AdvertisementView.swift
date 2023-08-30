//
//  AdvertisementView.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/26/23.
//

import UIKit

final class AdvertisementView: UIView {

    // MARK: - Private Properties
    
    private weak var delegate: AdvertisementsErrorViewDelegate?
    
    private let loadingView: LoadingViewProtocol = LoadingView()
    
    private let advertisementCollectionView = AdvertisementCollectionView()
    
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
    
    func configure(
        errorDelegate: AdvertisementsErrorViewDelegate,
        refreshControl: UIRefreshControl?,
        with setupCollectionViewBlock: (UICollectionView) -> Void
    ) {
        self.delegate = errorDelegate
        self.advertisementCollectionView.refreshControl = refreshControl
        setupCollectionViewBlock(advertisementCollectionView)
    }
    
    func startLoading() {
        advertisementCollectionView.isHidden = true
        loadingView.startAnimating()
    }
    
    func startPresent() {
        advertisementCollectionView.isHidden = false
        loadingView.stopAnimating()
    }
    
    func showError(message: String) {
        advertisementCollectionView.isHidden = true
        loadingView.stopAnimating()
        delegate?.showErrorAlert(message: message)
    }
}

// MARK: - Setup Layout, Constraints

private extension AdvertisementView {
    func setupLayout() {
        addSubview(advertisementCollectionView)
        self.backgroundColor = AppColors.background
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            advertisementCollectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            advertisementCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            advertisementCollectionView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            advertisementCollectionView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    private func setupLoadingView() {
        addSubview(loadingView)
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
}
