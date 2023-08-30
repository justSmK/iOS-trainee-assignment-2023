//
//  AdvertisementsPresenterProtocol.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/30/23.
//

import UIKit.UIImage

protocol AdvertisementsPresenterProtocol: AnyObject {
    func fetchData()
    func configureCell(at indexPath: IndexPath, completion: @escaping (Advertisement, UIImage?) -> Void)
    func didSelectItem(at indexPath: IndexPath)
}
