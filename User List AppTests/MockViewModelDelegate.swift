//
//  MockViewModelDelegate.swift
//  User List AppTests
//
//  Created by serhat yaroglu on 8.02.2025.
//

import Foundation
@testable import User_List_App

class MockViewModelDelegate: ViewModelDelegate {
    
    var didFetchCalled = false
    var didErrorCalled = false
    var receivedError: NetworkError?

    func userListDidFetch() {
        didFetchCalled = true
    }
    
    func errorOccurred(error: NetworkError) {
        didErrorCalled = true
        receivedError = error
    }
}
