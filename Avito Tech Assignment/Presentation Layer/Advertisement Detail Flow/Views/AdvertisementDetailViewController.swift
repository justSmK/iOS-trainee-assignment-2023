//
//  AdvertisementDetailViewController.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/28/23.
//

import UIKit

final class AdvertisementDetailViewController: UIViewController {
    
    var presenter: AdvertisementDetailPresenterProtocol?
    
    // MARK: - Private Properties
    
    private let advertisementDetailView: AdvertisementDetailView = AdvertisementDetailView()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = advertisementDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.fetchDetailData()
        advertisementDetailView.delegate = self
    }
}

// MARK: - AdvertisementDetailViewProtocol

extension AdvertisementDetailViewController: AdvertisementDetailViewProtocol {
    func showLoading() {
        advertisementDetailView.showLoading()
    }
    
    func showDetails(image: UIImage?, adDetailModel: AdvertisementDetail) {
        advertisementDetailView.showPresentStateConfigure(image: image, adDetailModel: adDetailModel)
    }
    
    func showError(message: String) {
        advertisementDetailView.showErrorState(message: message)
    }
}

// MARK: - AdvertisementDetailViewDelegate

extension AdvertisementDetailViewController: AdvertisementsErrorViewDelegate {
    func showErrorAlert(message: String) {
        let errorAlertController = ErrorViewAlertController(
            message: message,
            tryAgainHandler: presenter?.fetchDetailData
        )
        present(errorAlertController, animated: true)
    }
}
