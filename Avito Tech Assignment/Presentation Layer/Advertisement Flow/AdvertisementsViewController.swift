//
//  AdvertisementsViewController.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/24/23.
//

import UIKit

final class AdvertisementsViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let router: RouterProtocol
    
    private let advertisementService: AdvertisementServiceProtocol
    private let imageService: ImageServiceProtocol
    
    private var advertisements: Advertisements = []
    
    private let advertisementView: AdvertisementView
    
    // MARK: - Initializers
    
    init(
        advertisementService: AdvertisementServiceProtocol,
        imageService: ImageServiceProtocol,
        router: RouterProtocol,
        view: AdvertisementView
    ) {
        self.advertisementService = advertisementService
        self.imageService = imageService
        self.router = router
        self.advertisementView = view
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = self.advertisementView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        advertisementView.configure(dataSourceDelegate: self, tryAgainLoadData: fetchData)
        fetchData()
    }
    
    // MARK: - Private Methods
    
    private func fetchData() {
        advertisementView.currentState = .loading
        advertisementService.fetchAdvertisements { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.advertisementView.currentState = .present
                    self?.advertisements = response.advertisements
                case .failure(let error):
                    self?.advertisementView.currentState = .error("Error: \(error)")
                }
            }
        }
    }
    
    private func fetchImage(for advertisement: Advertisement, completion: @escaping (UIImage?) -> Void) {
        let itemId = advertisement.id
        imageService.fetchImage(itemId: itemId) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    completion(image)
                }
            case .failure(let error):
                print("Error \(error)")
                completion(nil)
            }
        }
    }
}

// MARK: - UICollectionViewDataSource

extension AdvertisementsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return advertisements.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AdvertisementCollectionViewCell.identifier,
            for: indexPath
        ) as? AdvertisementCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let advertisement = advertisements[indexPath.item]

        cell.currentId = advertisement.id
        
        fetchImage(for: advertisement) { image in
            if cell.currentId == advertisement.id {
                cell.configure(image: image, advertisementModel: advertisement)
            }
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension AdvertisementsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = (collectionView.bounds.size.width - 50) / 2
        let someSize = view.frame.height / 8
        print(someSize)
        return CGSize(width: width, height: width + someSize)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        let value = AppConstants.space
        return UIEdgeInsets(top: value, left: value, bottom: value, right: value)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return AppConstants.space
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return AppConstants.space
    }
    
    // MARK: Route to Advertisement Details
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let advertisement = advertisements[indexPath.item]
        router.showAdvertisementDetails(advertisementId: advertisement.id)
    }
}
