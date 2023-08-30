//
//  AdvertisementPresenter.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/30/23.
//

import UIKit.UIImage

final class AdvertisementPresenter {
    
    // MARK: - Private Properties
    
    private weak var view: AdvertisementViewProtocol?
    
    private let advertisementService: AdvertisementServiceProtocol
    private let imageService: ImageServiceProtocol
    private let router: RouterProtocol
    
    private var advertisements: Advertisements = []
    
    // MARK: - Initializers
    
    init(
        view: AdvertisementViewProtocol,
        advertisementService: AdvertisementServiceProtocol,
        imageService: ImageServiceProtocol,
        router: RouterProtocol
    ) {
        self.view = view
        self.advertisementService = advertisementService
        self.imageService = imageService
        self.router = router
    }
    
    // MARK: - Private Methods
    
    // MARK: Fetch Advertisements
    
    private func fetchAdvertisements() {
        advertisementService.fetchAdvertisements { [weak self] result in
            DispatchQueue.main.async {
                self?.handleFetchResult(result)
            }
        }
    }
    
    private func handleFetchResult(_ result: Result<AdvertisementsResponse, APIError>) {
        switch result {
        case .success(let response):
            advertisements = response.advertisements
            view?.showPresent(advertisements)
            view?.endRefreshing()
        case .failure(let error):
            view?.showError(message: error.localizedDescription)
        }
    }
    
    // MARK: Fetch Image
    private func loadImageFor(indexPath: IndexPath, completion: @escaping (UIImage?) -> Void) {
        let advertisement = advertisements[indexPath.item]
        let adId = advertisement.id
        imageService.fetchImage(itemId: adId) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    completion(image)
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    completion(nil)
                }
            }
        }
    }
}

// MARK: - AdvertisementsPresenterProtocol

extension AdvertisementPresenter: AdvertisementsPresenterProtocol {
    func fetchData() {
        view?.showLoading()
        fetchAdvertisements()
    }
    
    func configureCell(at indexPath: IndexPath, completion: @escaping (Advertisement, UIImage?) -> Void) {
        let advertisement = advertisements[indexPath.item]
        loadImageFor(indexPath: indexPath) { image in
            completion(advertisement, image)
        }
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        let advertisement = advertisements[indexPath.item]
        router.showAdvertisementDetails(advertisementId: advertisement.id)
    }
}
