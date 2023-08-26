//
//  AdvertisementView.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/26/23.
//

import UIKit

final class AdvertisementView: UIView {
    
    weak var delegate: AdvertisementViewDelegate?
    
    enum State {
        case loading
        case content
        case error(String)
    }
    
    private let loadingView = UIActivityIndicatorView()
    private let errorView = UILabel()
    
    var currentState: State = .loading {
        didSet {
            updateState()
        }
    }
    
    private let advertisementCollectionView = AdvertisementCollectionView()
    
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
    
    // MARK: - Internal Methods
    
    func configure(dataSourceDelegate: AdvertisementCollectionViewProtocols) {
        advertisementCollectionView.configure(dataSourceDelegate: dataSourceDelegate)
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
            advertisementCollectionView.isHidden = true
            loadingView.startAnimating()
        case .content:
            loadingView.isHidden = true
            advertisementCollectionView.isHidden = false
            loadingView.stopAnimating()
        case .error(let message):
            loadingView.isHidden = true
            advertisementCollectionView.isHidden = true
            loadingView.stopAnimating()
            errorView.text = message
        }
    }
}

// MARK: - Setup Layout, Constraints

private extension AdvertisementView {
    func setupLayout() {
        addSubview(advertisementCollectionView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            advertisementCollectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            advertisementCollectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            advertisementCollectionView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            advertisementCollectionView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}

extension AdvertisementView: CollectionAdvertisementProtocol {
    func reloadData() {
        advertisementCollectionView.reloadData()
    }
}
