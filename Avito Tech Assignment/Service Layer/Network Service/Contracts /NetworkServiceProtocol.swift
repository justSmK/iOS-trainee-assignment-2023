//
//  NetworkServiceProtocol.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/24/23.
//

import Foundation

protocol NetworkServiceProtocol {
    func performRequest(url: URL, httpMethod: HTTP.Method, completion: @escaping (Result<Data, APIError>) -> Void)
}
