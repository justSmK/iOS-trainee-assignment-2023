//
//  UIStackView + Extensions.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/29/23.
//

import UIKit.UIStackView

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach { view in
            addArrangedSubview(view)
        }
    }
}
