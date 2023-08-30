//
//  AdvertisementPresenterTests.swift
//  Avito Tech Assignment Tests
//
//  Created by Sergei Semko on 8/30/23.
//

import XCTest
@testable import Avito_Tech_Assignment

final class AdvertisementPresenterTests: XCTestCase {

    var presenter: AdvertisementPresenter!
    var mockView: MockAdvertisementView!
    var mockAdvertisementService: MockAdvertisementService!
    var mockImageService: MockImageService!
    var mockRouter: MockRouter!
    
    override func setUp() {
        super.setUp()
        
        mockView = MockAdvertisementView()
        mockAdvertisementService = MockAdvertisementService()
        mockImageService = MockImageService()
        mockRouter = MockRouter()
        
        presenter = AdvertisementPresenter(
            view: mockView,
            advertisementService: mockAdvertisementService,
            imageService: mockImageService,
            router: mockRouter
        )
    }
    
    override func tearDown() {
        mockView = nil
        mockAdvertisementService = nil
        mockImageService = nil
        mockRouter = nil
        presenter = nil
        
        super.tearDown()
    }
    
    func testFetchDataShowsLoading() {
        presenter.fetchData()
        XCTAssertTrue(mockView.isShowLoadingCalled)
    }
    
    func testFetchDataFetchesAdvertisements() {
        presenter.fetchData()
        XCTAssertTrue(mockAdvertisementService.isFetchAdvertisementsCalled)
    }
    
    func testFetchAdvertisementsSuccess() {
        let expectation = XCTestExpectation(description: "Fetch advertisements")
        let adv1 = Advertisement(id: "", title: "", price: "", location: "", imageURL: URL(string: "google.com")!, createdDate: Date())
        let adv2 = Advertisement(id: "", title: "", price: "", location: "", imageURL: URL(string: "google.com")!, createdDate: Date())
        
        mockAdvertisementService.fetchAdvertisementsResult = .success(AdvertisementsResponse(advertisements: [adv1, adv2]))
        
        presenter.fetchData()

        DispatchQueue.main.async {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertTrue(mockView.isShowPresentCalled)
    }
    
    func testFetchAdvertisementsFailure() {
        let expectation = XCTestExpectation(description: "Fetch advertisements failure")
        
        mockAdvertisementService.fetchAdvertisementsResult = .failure(APIError.urlSessionError("Error"))
        
        presenter.fetchData()
        
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertTrue(mockView.isShowErrorCalled)
    }
    
    func testDidSelectItemCallsRouter() {
        let expectation = XCTestExpectation(description: "Fetch advertisements for item selection")
        
        let adv1 = Advertisement(id: "", title: "", price: "", location: "", imageURL: URL(string: "google.com")!, createdDate: Date())
        let adv2 = Advertisement(id: "", title: "", price: "", location: "", imageURL: URL(string: "google.com")!, createdDate: Date())
        
        mockAdvertisementService.fetchAdvertisementsResult = .success(AdvertisementsResponse(advertisements: [adv1, adv2]))
        
        presenter.fetchData()
        
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
        
        presenter.didSelectItem(at: IndexPath(item: 0, section: 0))
        
        XCTAssertTrue(mockRouter.showAdvertisementDetailsCalled)
    }
}
