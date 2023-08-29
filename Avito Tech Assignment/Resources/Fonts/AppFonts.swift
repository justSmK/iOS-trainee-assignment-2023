//
//  AppFonts.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/26/23.
//

import UIKit.UIFont

enum AppFonts {
    enum Cell {
        static let title = UIFont.systemFont(ofSize: 16, weight: .regular)
        static let price = UIFont.systemFont(ofSize: 16, weight: .bold)
        static let location = UIFont.systemFont(ofSize: 14, weight: .light)
        static let createdDate = UIFont.systemFont(ofSize: 14, weight: .light)
    }
    
    enum Details {
        static let title = UIFont.systemFont(ofSize: 24, weight: .regular)
        static let price = UIFont.systemFont(ofSize: 26, weight: .bold)
        
        static let descriptionStaticLabel = UIFont.systemFont(ofSize: 20, weight: .bold)
        static let description = UIFont.systemFont(ofSize: 18, weight: .regular)
        
        static let email = UIFont.systemFont(ofSize: 16, weight: .regular)
        static let phone = UIFont.systemFont(ofSize: 16, weight: .regular)
        static let location = UIFont.systemFont(ofSize: 16, weight: .regular)
        static let createdDate = UIFont.systemFont(ofSize: 16, weight: .regular)
    }
}
