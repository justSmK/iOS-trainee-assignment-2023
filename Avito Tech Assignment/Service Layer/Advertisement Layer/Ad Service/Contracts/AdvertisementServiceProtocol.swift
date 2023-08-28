//
//  AdvertisementServiceProtocol.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/28/23.
//

import Foundation

protocol AdvertisementServiceProtocol: AnyObject {
    func fetchAdvertisements(completion: @escaping (Result<AdvertisementsResponse, APIError>) -> Void)
    func fetchAdvertisementDetail(itemId: String, completion: @escaping (Result<AdvertisementDetail, APIError>) -> Void)
}
