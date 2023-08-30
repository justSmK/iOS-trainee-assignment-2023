//
//  MockServiceFactory.swift
//  Avito Tech Assignment Tests
//
//  Created by Sergei Semko on 8/30/23.
//

import Foundation
@testable import Avito_Tech_Assignment

final class MockServiceFactory: ServiceFactoryProtocol {
    
    var mockNetworkService: NetworkServiceProtocol!
    var mockImageClient: ImageAPIClientProtocol!
    var mockImageService: ImageServiceProtocol!
    var mockAdvertisementClient: AdvertisementAPIClientProtocol!
    var mockAdvertisementService: AdvertisementServiceProtocol!
    
    func createNetworkService() -> NetworkServiceProtocol {
        return mockNetworkService
    }
    
    func createImageClient(networkService: NetworkServiceProtocol) -> ImageAPIClientProtocol {
        return mockImageClient
    }
    
    func createImageService(imageClient: ImageAPIClientProtocol) -> ImageServiceProtocol {
        return mockImageService
    }
    
    func createAdvertisementClient(networkService: NetworkServiceProtocol) -> AdvertisementAPIClientProtocol {
        return mockAdvertisementClient
    }
    
    func createAdvertisementService(adClient: AdvertisementAPIClientProtocol) -> AdvertisementServiceProtocol {
        return mockAdvertisementService
    }
}
