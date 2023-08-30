//
//  Formattable.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/29/23.
//

import Foundation

protocol Formattable {
    var createdDate: Date { get }
    var price: String { get }
}

extension Formattable {
    var formattedCreatedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, d MMM yyyy"
        let formatted = dateFormatter.string(from: createdDate)
        // For Russian language
        let capitalizedDate = formatted.prefix(1).uppercased() + formatted.dropFirst()
        return capitalizedDate
    }
    
    var formattedPrice: String {
        let components = price.split(separator: " ")
        if let numberString = components.first,
           let currency = components.last {
            let formatter = NumberFormatter()
            formatter.groupingSeparator = " "
            formatter.numberStyle = .decimal
            if let number = Int(numberString),
               let formattedNumber = formatter.string(from: NSNumber(value: number)) {
                return "\(formattedNumber) \(currency)"
            }
        }
        return price
    }
}
