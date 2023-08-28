//
//  AdvertisementDetailViewController.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/28/23.
//

import UIKit

final class AdvertisementDetailViewController: UIViewController {
    
    private let advertisementService: AdvertisementServiceProtocol
    
    private let imageService: ImageServiceProtocol
    
    private var advertisementDetail: AdvertisementDetail?
    
    private let advertisementDetailView: AdvertisementDetailView
    
    private let adId: String
    
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
    
    override func loadView() {
        view = advertisementDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDetailData(for: adId)
    }
    

    private func loadDetailData(for advertisementId: String) {
        advertisementService.fetchAdvertisementDetail(itemId: advertisementId) { [weak self] result in
            switch result {
                
            case .success(let adDetail):
                DispatchQueue.main.async {
                    self?.advertisementDetail = adDetail
                    self?.advertisementDetailView.configure(adDetailModel: adDetail)
                    self?.advertisementDetailView.currentState = .present
                }
                self?.loadImage(for: adDetail, completion: { image in
                    DispatchQueue.main.async {
                        self?.advertisementDetailView.configure(image: image)
                    }
                })
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func loadImage(for advertisementDetail: AdvertisementDetail, completion: @escaping (UIImage?) -> Void) {
        let url = advertisementDetail.imageURL

        imageService.fetchImage(from: url) { result in
            switch result {
            case .success(let image):
//                DispatchQueue.main.async {
//                    completion(image)
//                }
                completion(image) // !!!!!!
            case .failure(let error):
                print("Error \(error)")
                completion(nil)
            }
        }
    }
    
}
