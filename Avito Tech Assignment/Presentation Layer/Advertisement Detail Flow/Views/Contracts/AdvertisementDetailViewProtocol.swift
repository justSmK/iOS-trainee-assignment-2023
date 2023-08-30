//
//  AdvertisementDetailViewProtocol.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/30/23.
//

import UIKit.UIImage

protocol AdvertisementDetailViewProtocol: AnyObject {
    func showLoading()
    func showDetails(image: UIImage?, adDetailModel: AdvertisementDetail)
    func showError(message: String)
}
