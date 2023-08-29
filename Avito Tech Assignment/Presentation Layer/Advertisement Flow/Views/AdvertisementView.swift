//
//  AdvertisementView.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/26/23.
//

import UIKit

final class AdvertisementView: UIView {
    
    enum State {
        case loading
        case present
        case error(String)
    }
    
    var currentState: State = .loading {
        didSet {
            updateState()
        }
    }
    
    // MARK: - Private Properties
    
    private let loadingView: LoadingViewProtocol = LoadingView()
    
    private var tryAgainLoadData: (() -> Void)?
    
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
    
    func configure(dataSourceDelegate: AdvertisementCollectionViewProtocols, refreshControl: UIRefreshControl?, tryAgainLoadData: (() -> Void)?) {
        advertisementCollectionView.configure(dataSourceDelegate: dataSourceDelegate)
        self.tryAgainLoadData = tryAgainLoadData
        self.advertisementCollectionView.refreshControl = refreshControl
    }
    
    // MARK: - Private Methods
    
    private func updateState() {
        
        switch currentState {
            
        case .loading:
            advertisementCollectionView.isHidden = true
            loadingView.startAnimating()
        case .present:
            advertisementCollectionView.isHidden = false
            advertisementCollectionView.reloadData()
            loadingView.stopAnimating()
        case .error(let message):
            advertisementCollectionView.isHidden = true
            loadingView.stopAnimating()
            showErrorAlert(message: message)
        }
    }
    
    private func showErrorAlert(message: String) {
        if let viewController = self.findViewController() {
            let errorAlertController = ErrorViewAlertController(message: message, tryAgainHandler: self.tryAgainLoadData)
            viewController.present(errorAlertController, animated: true)
        }
    }
    
    private func findViewController() -> UIViewController? {
        var responder: UIResponder? = self
        while !(responder is UIViewController) && responder != nil {
            responder = responder?.next
        }
        return responder as? UIViewController
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
            advertisementCollectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
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
