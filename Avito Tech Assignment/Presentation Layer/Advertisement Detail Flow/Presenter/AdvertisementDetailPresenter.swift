//
//  AdvertisementDetailPresenter.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/30/23.
//

import Foundation

final class AdvertisementDetailPresenter {
    
    // MARK: - Private Properties
    
    private weak var view: AdvertisementDetailViewProtocol?
    
    private let advertisementService: AdvertisementServiceProtocol
    private let imageService: ImageServiceProtocol
    private let adId: String
    
    // MARK: - Initializers
    
    init(
        view: AdvertisementDetailViewProtocol,
        advertisementId: String,
        advertisementService: AdvertisementServiceProtocol,
        imageService: ImageServiceProtocol
    ) {
        self.view = view
        self.adId = advertisementId
        self.advertisementService = advertisementService
        self.imageService = imageService
    }
    
    // MARK: - Private Methods
    
    // MARK: Fetch Advertisement Detail Data
    
    private func fetchAdDetailData() {
        view?.showLoading()
        advertisementService.fetchAdvertisementDetail(itemId: adId) { [weak self] result in
            DispatchQueue.main.async {
                self?.handleAdDetailFetchResult(result)
            }
        }
    }

    private func handleAdDetailFetchResult(_ result: Result<AdvertisementDetail, APIError>) {
        switch result {
        case .success(let adDetail):
            fetchImage(for: adDetail)
        case .failure(let error):
            view?.showError(message: error.localizedDescription)
        }
    }
    
    // MARK: Fetch Image
    
    private func fetchImage(for advertisementDetail: AdvertisementDetail) {
        let url = advertisementDetail.imageURL
        imageService.fetchImage(from: url) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self?.view?.showDetails(image: image, adDetailModel: advertisementDetail)
                case .failure(let error):
                    print("Error \(error)")
                    self?.view?.showError(message: error.localizedDescription)
                }
            }
        }
    }
}

// MARK: - AdvertisementDetailPresenterProtocol

extension AdvertisementDetailPresenter: AdvertisementDetailPresenterProtocol {
    func fetchDetailData() {
        fetchAdDetailData()
    }
}
