//
//  MockAdvertisementDetailView.swift
//  Avito Tech Assignment Tests
//
//  Created by Sergei Semko on 8/30/23.
//

import UIKit.UIImage
@testable import Avito_Tech_Assignment

final class MockAdvertisementDetailView: AdvertisementDetailViewProtocol {

    var isShowLoadingCalled = false
    var isShowPresentCalled = false
    var isShowErrorCalled = false
    
    var lastImage: UIImage?
    var lastAdDetailModel: AdvertisementDetail?
    var lastErrorMessage: String?
    
    func showLoading() {
        isShowLoadingCalled = true
    }
    
    func showDetails(image: UIImage?, adDetailModel: Avito_Tech_Assignment.AdvertisementDetail) {
        print("MockView Show")
        isShowPresentCalled = true
        lastImage = image
        lastAdDetailModel = adDetailModel
    }
    
    func showError(message: String) {
        isShowErrorCalled = true
        lastErrorMessage = message
    }
}
