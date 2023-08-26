//
//  ImageServiceProtocol.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/25/23.
//

import UIKit.UIImage

protocol ImageServiceProtocol {
    func fetchImage(itemId: String, completion: @escaping (Result<UIImage, APIError>) -> Void)
    func fetchImage(from url: URL, completion: @escaping (Result<UIImage, APIError>) -> Void)

    func prefetchImage(from url: URL)
}
