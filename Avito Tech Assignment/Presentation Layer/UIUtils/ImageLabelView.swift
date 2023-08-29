//
//  ImageLabelView.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/29/23.
//

import UIKit

final class ImageLabelView: UIView {
    
    // MARK: - Initializers
    
    init(imageView: UIImageView, label: UILabel) {
        super.init(frame: .zero)
        addSubviews(imageView, label)
        setupConstraints(imageView: imageView, label: label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupConstraints(imageView: UIImageView, label: UILabel) {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.heightAnchor.constraint(equalTo: label.heightAnchor, multiplier: 1),
            
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
