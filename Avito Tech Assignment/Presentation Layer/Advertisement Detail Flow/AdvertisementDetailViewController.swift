//
//  AdvertisementDetailViewController.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/28/23.
//

import UIKit

final class AdvertisementDetailViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let advertisementService: AdvertisementServiceProtocol
    
    private let imageService: ImageServiceProtocol
    
    private let advertisementDetailView: AdvertisementDetailView
    
    private let adId: String
    
    // MARK: - Initializers
    
    init(advertisementId: String, advertisementService: AdvertisementServiceProtocol, imageService: ImageServiceProtocol, view: AdvertisementDetailView) {
        self.adId = advertisementId
        self.advertisementService = advertisementService
        self.imageService = imageService
        self.advertisementDetailView = view
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = advertisementDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDetailData()
        advertisementDetailView.configureErrorAction(tryAgainLoadData: fetchDetailData)
    }
    
    // MARK: - Private Methods

    private func fetchDetailData() {
        advertisementDetailView.currentState = .loading
        advertisementService.fetchAdvertisementDetail(itemId: adId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let adDetail):
                    self?.fetchImage(for: adDetail, completion: { image in
                        self?.advertisementDetailView.configure(image: image, adDetailModel: adDetail)
                        self?.advertisementDetailView.currentState = .present
                    })
                case .failure(let error):
                    print("Error \(error)")
                    self?.advertisementDetailView.currentState = .error("Error: \(error)")
                }
            }
        }
    }
    
    private func fetchImage(for advertisementDetail: AdvertisementDetail, completion: @escaping (UIImage?) -> Void) {
        let url = advertisementDetail.imageURL

        imageService.fetchImage(from: url) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    completion(image)
                case .failure(let error):
                    print("Error \(error)")
                    completion(nil)
                }
            }
        }
    }
    
}
