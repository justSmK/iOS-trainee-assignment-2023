//
//  AdvertisementViewDelegate.swift
//  Avito Tech Assignment
//
//  Created by Sergei Semko on 8/26/23.
//

import UIKit

protocol AdvertisementViewDelegate: AnyObject {
    func reloadData()
    func showError(_ message: String)
    func startLoading()
}
