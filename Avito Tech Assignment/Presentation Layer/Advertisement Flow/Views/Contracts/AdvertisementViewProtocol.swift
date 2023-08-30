//
//  AdvertisementViewProtocol.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/30/23.
//

protocol AdvertisementViewProtocol: AnyObject {
    func showLoading()
    func showPresent()
    func showError(message: String)
}
