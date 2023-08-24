//
//  NetworkServiceProtocol.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/24/23.
//

//import Foundation

protocol NetworkServiceProtocol {
    func fetchAdvertisements(completion: @escaping (Result<AdvertisementsResponse, APIError>) -> Void)
    func fetchAdvertisementDetail(itemId: String, completion: @escaping (Result<AdvertisementDetail, APIError>) -> Void)
}
