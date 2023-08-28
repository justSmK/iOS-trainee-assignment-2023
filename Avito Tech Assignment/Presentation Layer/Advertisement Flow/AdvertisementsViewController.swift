//
//  AdvertisementsViewController.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/24/23.
//

import UIKit

final class AdvertisementsViewController: UIViewController {
    
    private let router: RouterProtocol
    
    private let advertisementService: AdvertisementServiceProtocol
    
    private let imageService: ImageServiceProtocol
    
    private var advertisements: Advertisements = []
    
    private let advertisementView: AdvertisementView
    
    init(advertisementService: AdvertisementServiceProtocol, imageService: ImageServiceProtocol, router: RouterProtocol, view: AdvertisementView) {
        self.advertisementService = advertisementService
        self.imageService = imageService
        self.router = router
        self.advertisementView = view
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = self.advertisementView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        advertisementView.configure(dataSourceDelegate: self)
        loadData()
    }
    
    private func loadData() {
        advertisementView.currentState = .loading
        advertisementService.fetchAdvertisements { [weak self] result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self?.advertisementView.currentState = .content
                    self?.advertisements = response.advertisements
                    self?.advertisementView.reloadData()
                }
            case .failure(let error):
                print("Error \(error)")
                DispatchQueue.main.async {
                    self?.advertisementView.currentState = .error("Error: \(error)")
                }
            }
        }

    }
    
    private func loadImage(for advertisement: Advertisement, completion: @escaping (UIImage?) -> Void) {
        let id = advertisement.id
        imageService.fetchImage(itemId: id) { result in
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
    
//    private func loadImage(for advertisement: Advertisement, completion: @escaping (UIImage?) -> Void) {
//        let url = advertisement.imageURL
//
//        imageService.fetchImage(from: url) { result in
//            switch result {
//            case .success(let image):
//                DispatchQueue.main.async {
//                    completion(image)
//                }
//            case .failure(let error):
//                print("Error \(error)")
//                completion(nil)
//            }
//        }
//    }
    
}


extension AdvertisementsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return advertisements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AdvertisementCollectionViewCell.identifier, for: indexPath) as? AdvertisementCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let advertisement = advertisements[indexPath.item]
        
        cell.currentId = advertisement.id
        
        cell.activityIndicator.startAnimating()
        cell.backgroundColor = .clear
        
        loadImage(for: advertisement) { image in
            if cell.currentId == advertisement.id {
                cell.configure(image: image, advertisementModel: advertisement)
            }
        }
        
        return cell
    }
}

extension AdvertisementsViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            let advertisement = advertisements[indexPath.item]
//            imageService.prefetchImage(from: advertisement.imageURL)
//            imageService.prefetchImage(from: advertisement.imageURL)
            
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
//        for indexPath in indexPaths {
//            let advertisement = advertisements[indexPath.item]
//            imageService.cancelPrefetch(from: advertisement.imageURL)
//        }
//    }
}

extension AdvertisementsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.size.width - 50) / 2
        return CGSize(width: width, height: width + 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let advertisement = advertisements[indexPath.item]
        
        router.showAdvertisementDetails(advertisementId: advertisement.id)
    }
}

