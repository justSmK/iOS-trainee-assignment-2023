//
//  ImageAPIClientProtocol.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/28/23.
//

import Foundation

protocol ImageAPIClientProtocol {
    func fetchImageData(from url: URL, completion: @escaping (Result<Data, APIError>) -> Void)
}
