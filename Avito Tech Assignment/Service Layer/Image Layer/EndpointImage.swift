//
//  EndpointImage.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/26/23.
//

import Foundation

enum EndpointImage {
    case fetchImage(itemId: String)
    
    var url: URL? {
        let baseUrl = "https://www.avito.st/s/interns-ios/"
        switch self {
        case .fetchImage(let itemId):
            return URL(string: baseUrl + "images/\(itemId).png")
        }
    }
}
