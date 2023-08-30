//
//  AdvertisementDetailPresenterTests.swift
//  Avito Tech Assignment Tests
//
//  Created by Sergei Semko on 8/30/23.
//

import XCTest
@testable import Avito_Tech_Assignment

final class AdvertisementDetailPresenterTests: XCTestCase {
    
    var presenter: AdvertisementDetailPresenter!
    var mockView: MockAdvertisementDetailView!
    var mockAdvertisementService: MockAdvertisementService!
    var mockImageService: MockImageService!
    
    override func setUp() {
        super.setUp()
        
        mockView = MockAdvertisementDetailView()
        mockAdvertisementService = MockAdvertisementService()
        mockImageService = MockImageService()
        presenter = AdvertisementDetailPresenter(
            view: mockView,
            advertisementId: "1",
            advertisementService: mockAdvertisementService,
            imageService: mockImageService
        )
    }
    
    override func tearDown() {
        mockView = nil
        mockAdvertisementService = nil
        mockImageService = nil
        presenter = nil
        
        super.tearDown()
    }
    
    func testFetchDetailDataShowsLoading() {
        presenter.fetchDetailData()
        XCTAssertTrue(mockView.isShowLoadingCalled)
    }
    
    func testFetchDetailDataFetchesAdvertisements() {
        presenter.fetchDetailData()
        XCTAssertTrue(mockAdvertisementService.isFetchAdvertisementDetailCalled)
    }

    func testFetchAdvertisementsDetailsSuccess() {
        let adDetailExpectation = XCTestExpectation(description: "Fetch completed")

        let adDetail = AdvertisementDetail(id: "", title: "", price: "", location: "", imageURL: URL(string: "google.com")!, createdDate: Date(), description: "", email: "", phoneNumber: "", address: "")


        mockAdvertisementService.fetchAdvertisementDetailResult = .success(adDetail)
        mockImageService.fetchImageFromURLResult = .success(UIImage())

        presenter.fetchDetailData()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            adDetailExpectation.fulfill()
        }

        wait(for: [adDetailExpectation], timeout: 1.0)

        XCTAssertTrue(mockView.isShowPresentCalled)
    }
    
    func testFetchAdvertisementsDetailFailure() {
        let expectation = XCTestExpectation(description: "Fetch advertisements failure")
        
        mockAdvertisementService.fetchAdvertisementDetailResult = .failure(APIError.urlSessionError("Error"))
        
        presenter.fetchDetailData()
        
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertTrue(mockView.isShowErrorCalled)
    }
    
}
