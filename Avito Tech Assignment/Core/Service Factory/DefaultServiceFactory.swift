//
//  DefaultServiceFactory.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/28/23.
//

import Foundation

final class DefaultServiceFactory: ServiceFactoryProtocol {
    func createNetworkService() -> NetworkServiceProtocol {
        let configuration = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: configuration)
        return NetworkService(session: urlSession)
    }
    
    func createImageClient(networkService: NetworkServiceProtocol) -> ImageAPIClientProtocol {
        return ImageAPIClient(networkService: networkService)
    }
    
    func createImageService(imageClient: ImageAPIClientProtocol) -> ImageServiceProtocol {
        return ImageService(imageClient: imageClient)
    }
    
    func createAdvertisementClient(networkService: NetworkServiceProtocol) -> AdvertisementAPIClientProtocol {
        return AdvertisementAPIClient(networkService: networkService)
    }
    
    func createAdvertisementService(adClient: AdvertisementAPIClientProtocol) -> AdvertisementServiceProtocol {
        return AdvertisementService(advertisementClient: adClient)
    }
}
