//
//  LoadingView.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/29/23.
//

import UIKit

final class LoadingView: UIView {
    
    // MARK: - Private Properties
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicatorView)
        
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
}

// MARK: - LoadingViewProtocol

extension LoadingView: LoadingViewProtocol {
    func startAnimating() {
        self.isHidden = false
        activityIndicatorView.startAnimating()
    }
    
    func stopAnimating() {
        activityIndicatorView.stopAnimating()
    }
}
