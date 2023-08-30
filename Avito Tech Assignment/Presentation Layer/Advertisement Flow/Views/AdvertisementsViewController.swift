//
//  AdvertisementsViewController.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/24/23.
//

import UIKit

final class AdvertisementsViewController: UIViewController {
    
    var presenter: AdvertisementsPresenterProtocol?
    
    // MARK: - Private Properties
    
    private let advertisementView: AdvertisementView = AdvertisementView()
    
    private var refreshControl: UIRefreshControl?
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = self.advertisementView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefreshControl()
        
        advertisementView.configure(
            dataSourceDelegate: self,
            delegate: self,
            refreshControl: refreshControl
        )
        presenter?.fetchData()
    }
    
    // MARK: - Private Methods
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
    
    @objc
    private func handleRefreshControl() {
        presenter?.fetchData()
        refreshControl?.endRefreshing()
    }
}

// MARK: - AdvertisementViewProtocol

extension AdvertisementsViewController: AdvertisementViewProtocol {
    func showLoading() {
        advertisementView.startLoading()
    }
    
    func showPresent() {
        advertisementView.startPresent()
    }
    
    func showError(message: String) {
        advertisementView.showError(message: message)
    }
}

// MARK: - AdvertisementsErrorViewDelegate

extension AdvertisementsViewController: AdvertisementsErrorViewDelegate {
    func showErrorAlert(message: String) {
        let errorAlertController = ErrorViewAlertController(
            message: message,
            tryAgainHandler: presenter?.fetchData
        )
        present(errorAlertController, animated: true)
    }
}

// MARK: - UICollectionViewDataSource

extension AdvertisementsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let presenter else { return 0 }
        return presenter.getAdvertisementCount()
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
        
        presenter?.configure(cell: cell, at: indexPath)
        
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
        let offset = AppConstants.space * 3 // left + middle min space + right
        let width = (collectionView.bounds.size.width - offset) / 2
        let someSize = view.frame.height / 8
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
        presenter?.didSelectItem(at: indexPath)
    }
}
