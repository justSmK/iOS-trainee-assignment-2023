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
    
    var currentState: State = .loading {
        didSet {
            updateState()
        }
    }
    
    // MARK: - Private Properties
    
    private let loadingView: LoadingViewProtocol = LoadingView()
    
    private var tryAgainLoadData: (() -> Void)?
    
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
    
    func configure(image: UIImage?, adDetailModel: AdvertisementDetail) {
        adDetailsView.configure(image: image, adDetailModel: adDetailModel)
    }
    
    func configureErrorAction(tryAgainLoadData: (() -> Void)?) {
        self.tryAgainLoadData = tryAgainLoadData
    }
    
    // MARK: - Private Methods
    
    private func updateState() {
        
        switch currentState {
            
        case .loading:
            adDetailsView.isHidden = true
            loadingView.startAnimating()
        case .present:
            adDetailsView.isHidden = false
            loadingView.stopAnimating()
        case .error(let message):
            adDetailsView.isHidden = true
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

