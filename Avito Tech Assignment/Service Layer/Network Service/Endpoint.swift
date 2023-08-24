//
//  Endpoint.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/24/23.
//

import Foundation

// https://www.avito.st/s/interns-ios/main-page.json

enum Endpoint {
    case fetchAdvertisements
    case fetchAdvertisementDetail(itemId: String)
    
    var url: URL? {
        let baseUrl = "https://www.avito.st/s/interns-ios/"
        switch self {
        case .fetchAdvertisements:
            return URL(string: baseUrl + "main-page.json")
        case .fetchAdvertisementDetail(let itemId):
            return URL(string: baseUrl + "details/\(itemId).json")
        }
    }
}
