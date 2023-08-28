//
//  AdvertisementDetail.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/24/23.
//

import Foundation

struct AdvertisementDetail: Codable {
    let id, title, price, location: String
    let imageURL: URL
    let createdDate: Date
    let description, email, phoneNumber: String
    let address: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, price, location
        case imageURL = "image_url"
        case createdDate = "created_date"
        case description, email
        case phoneNumber = "phone_number"
        case address
    }
    
    var formattedCreatedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, d MMM yyyy"
        let formatted = dateFormatter.string(from: createdDate)
        // For Russian language
        let capitalizedDate = formatted.prefix(1).uppercased() + formatted.dropFirst()
        return capitalizedDate
    }
}
