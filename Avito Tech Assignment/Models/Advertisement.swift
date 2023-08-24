//
//  Advertisement.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/24/23.
//

import Foundation

struct AdvertisementsResponse: Codable {
    let advertisements: [Advertisement]
}

struct Advertisement: Codable {
    let id, title, price, location: String
    let imageURL: String
    let createdDate: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, price, location
        case imageURL = "image_url"
        case createdDate = "created_date"
    }
}
