//
//  ViewModelTest.swift
//  User List AppTests
//
//  Created by serhat yaroglu on 8.02.2025.
//

import Foundation
import XCTest
@testable import User_List_App

class ViewModelTests: XCTestCase {
    
    var viewModel: ViewModel!
    var mockNetwork: MockNetworkLayer!
    var mockDelegate: MockViewModelDelegate!

    override func setUp() {
        super.setUp()
        mockNetwork = MockNetworkLayer()
        mockDelegate = MockViewModelDelegate()
        viewModel = ViewModel(network: mockNetwork)
        viewModel.delegate = mockDelegate
    }

    override func tearDown() {
        viewModel = nil
        mockNetwork = nil
        mockDelegate = nil
        super.tearDown()
    }

    func testFetchUserList_Success() {
        mockNetwork.shouldReturnError = false
        let fakeUser = UserList(
            id: 1,
            name: "Test User",
            username: "testusername",
            email: "test@test.com",
            address: Address(street: "", suite: "", city: "", zipcode: "", geo: Geo(lat: "", lng: "")),
            phone: "123456",
            website: "test.com",
            company: Company(name: "", catchPhrase: "", bs: "")
        )
        mockNetwork.mockUserList = [fakeUser]

        viewModel.fetchUserList(for: .users)


        XCTAssertTrue(mockDelegate.didFetchCalled, "userListDidFetch() çağrılmalıydı.")
        XCTAssertFalse(mockDelegate.didErrorCalled, "errorOccurred() çağrılmamalıydı.")
        XCTAssertEqual(viewModel.arrUserList.count, 1, "Bir adet kullanıcı dönmeli.")
        XCTAssertEqual(viewModel.arrUserList.first?.username, "testusername")
    }

    func testFetchUserList_Failure() {
        mockNetwork.shouldReturnError = true

        viewModel.fetchUserList(for: .users)

        XCTAssertFalse(mockDelegate.didFetchCalled, "Başarısız senaryoda fetch metodu çağrılmamalıydı.")
        XCTAssertTrue(mockDelegate.didErrorCalled, "Hata senaryosunda errorOccurred() çağrılmalı.")
        XCTAssertEqual(mockDelegate.receivedError, .decodingError, "Beklenen hata decodingError olmalı.")
        XCTAssertEqual(viewModel.arrUserList.count, 0, "Hata durumunda liste boş kalmalı.")
    }
}
