//
//  ViewController.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/24/23.
//

import UIKit

class ViewController: UIViewController {
    
    private let networkService: NetworkServiceProtocol
    
    private var advertisements: [Advertisement] = []
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        loadData()
        
        sleep(3)
        
        print(advertisements)
        
//        networkLayer.fetchAdvertisements { result in
//            switch result {
//            case .success(let advertisementsResponse):
//                print(advertisementsResponse.advertisements.first)
//            case .failure(let error):
//                print("Error fetching advertisements: \(error)")
//            }
//        }
        
//        networkLayer.fetchAdvertisementDetail(itemId: "1") { result in
//            switch result {
//            case .success(let advertisementDetail):
//                print(advertisementDetail)
//            case .failure(let error):
//                print("Error fetching advertisements: \(error)")
//            }
//        }
    }
    
    private func loadData() {
        networkService.fetchAdvertisements { [weak self] result in
            switch result {
            case .success(let response):
                self?.advertisements = response.advertisements
            case .failure(let error):
                print("Error \(error)")
            }
        }
    }

}

