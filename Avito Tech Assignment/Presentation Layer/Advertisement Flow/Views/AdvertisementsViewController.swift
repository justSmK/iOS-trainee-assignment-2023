//
//  AdvertisementsViewController.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/24/23.
//

import UIKit

final class AdvertisementsViewController: UIViewController {
    
    private enum Section {
        case main
    }
  
    var presenter: AdvertisementsPresenterProtocol?
    
    // MARK: - Private Properties
    
    private let advertisementView: AdvertisementView = AdvertisementView()
    
    private var refreshControl: UIRefreshControl?
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Advertisement>?

    // MARK: - Life Cycle
    
    override func loadView() {
        view = self.advertisementView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.fetchData()
        setupRefreshControl()
        
        advertisementView.configure(errorDelegate: self, refreshControl: refreshControl) { collectionView in
            collectionView.delegate = self
            dataSource = UICollectionViewDiffableDataSource<Section, Advertisement>(
                collectionView: collectionView,
                cellProvider: { [weak self] collectionView, indexPath, itemIdentifier in
                    guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: AdvertisementCollectionViewCell.identifier,
                        for: indexPath
                    ) as? AdvertisementCollectionViewCell else {
                        return UICollectionViewCell()
                    }
                    
                    self?.presenter?.configureCell(at: indexPath, completion: { advertisement, image in
                        cell.configure(image: image, advertisementModel: advertisement)
                    })
                    
                    return cell
                })
        }
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
    
    private func updateCollectionView(with items: [Advertisement]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Advertisement>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: - AdvertisementViewProtocol

extension AdvertisementsViewController: AdvertisementViewProtocol {

    func endRefreshing() {
        refreshControl?.endRefreshing()
    }
  
    func showLoading() {
        advertisementView.startLoading()
    }
    
    func showPresent(_ advertisements: Advertisements) {
        advertisementView.startPresent()
        updateCollectionView(with: advertisements)
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

// MARK: - UICollectionViewDelegate

extension AdvertisementsViewController: UICollectionViewDelegate {
  
    // MARK: Route to Advertisement Details
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectItem(at: indexPath)
    }
}
