//
//  Advertisement.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/24/23.
//

import Foundation

typealias Advertisements = [Advertisement]

struct Advertisement: Codable, Formattable {
    let id, title, price, location: String
    let imageURL: URL
    var createdDate: Date
    
    enum CodingKeys: String, CodingKey {
        case id, title, price, location
        case imageURL = "image_url"
        case createdDate = "created_date"
    }
}
