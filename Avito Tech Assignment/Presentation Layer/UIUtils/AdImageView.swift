//
//  AdImageView.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/29/23.
//

import UIKit

final class AdImageView: UIImageView {
    
    // MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 12
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
