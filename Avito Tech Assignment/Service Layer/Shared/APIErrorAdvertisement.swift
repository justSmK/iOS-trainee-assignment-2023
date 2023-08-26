//
//  APIErrorAdvertisement.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/26/23.
//

import Foundation

enum APIError: Error {
    case urlSessionError(String)
    case noInternetConnection(String = "No Internet Connection")
    case serverError(String = "Invalid API Key")
    case invalidResponse(String = "Invalid response from server")
    case decodingError(String = "Error parsing server response")
}
