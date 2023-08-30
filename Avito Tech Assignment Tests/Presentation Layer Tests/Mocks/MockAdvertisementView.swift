//
//  MockAdvertisementView.swift
//  Avito Tech Assignment Tests
//
//  Created by Sergei Semko on 8/30/23.
//

import Foundation
@testable import Avito_Tech_Assignment

final class MockAdvertisementView: AdvertisementViewProtocol {
    
    var isShowLoadingCalled = false
    var isShowPresentCalled = false
    var isShowErrorCalled = false
    
    var lastErrorMessage: String?
    
    func showLoading() {
        isShowLoadingCalled = true
    }
    
    func showPresent(_ advertisements: Avito_Tech_Assignment.Advertisements) {
        isShowPresentCalled = true
    }
    
    func endRefreshing() {
        isShowPresentCalled = true
    }
    
    func showError(message: String) {
        isShowErrorCalled = true
        lastErrorMessage = message
    }
}
