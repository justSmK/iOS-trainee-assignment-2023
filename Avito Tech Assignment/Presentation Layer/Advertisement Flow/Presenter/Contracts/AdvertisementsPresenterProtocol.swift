//
//  AdvertisementsPresenterProtocol.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/30/23.
//

import Foundation

protocol AdvertisementsPresenterProtocol: AnyObject {
    func fetchData()
    func getAdvertisementCount() -> Int
    func configure(cell: AdvertisementCollectionViewCell, at indexPath: IndexPath)
    func didSelectItem(at indexPath: IndexPath)
}
