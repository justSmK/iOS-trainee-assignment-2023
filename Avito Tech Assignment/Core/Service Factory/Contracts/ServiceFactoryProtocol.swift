//
//  ServiceFactoryProtocol.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/28/23.
//

protocol ServiceFactoryProtocol: AnyObject {
    func createNetworkService() -> NetworkServiceProtocol
    func createImageClient(networkService: NetworkServiceProtocol) -> ImageAPIClientProtocol
    func createImageService(imageClient: ImageAPIClientProtocol) -> ImageServiceProtocol
    func createAdvertisementClient(networkService: NetworkServiceProtocol) -> AdvertisementAPIClientProtocol
    func createAdvertisementService(adClient: AdvertisementAPIClientProtocol) -> AdvertisementServiceProtocol
}
