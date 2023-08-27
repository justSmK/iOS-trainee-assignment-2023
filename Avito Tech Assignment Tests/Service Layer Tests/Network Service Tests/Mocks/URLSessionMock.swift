//
//  URLSessionMock.swift
//  Avito Tech Assignment Tests
//
//  Created by Sergei Semko on 8/27/23.
//

import Foundation
@testable import Avito_Tech_Assignment

class URLSessionMock: URLSession {
    var error: Error?
    var response: URLResponse?
    var data: Data?
    
    init(error: Error?, response: URLResponse?, data: Data?) {
        self.error = error
        self.response = response
        self.data = data
        print("init")
    }
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return URLSessionDataTaskMock {
            completionHandler(self.data, self.response, self.error)
        }
    }

}

class URLSessionDataTaskMock: URLSessionDataTask {
    private let closure: () -> Void
    
    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    
    override func resume() {
        closure()
    }
}
