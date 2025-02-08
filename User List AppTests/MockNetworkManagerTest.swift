//
//  MockNetworkManagerTest.swift
//  User List AppTests
//
//  Created by serhat yaroglu on 8.02.2025.
//


import XCTest
@testable import User_List_App

class NetworkManagerTest: XCTestCase {

   private var networkManager: NetworkManager!
    var testSession: URLSession!

    override func setUp() {
        super.setUp()
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        testSession = URLSession(configuration: config)

        // 2) NetworkManager init ederken testSession veriyoruz
        networkManager = NetworkManager(session: testSession)
    }
    override func tearDown() {
        testSession = nil
        networkManager = nil
        super.tearDown()
    }

    func testRequest_Success() {
        let expectedJSON = """
        [
          {
            "id": 1,
            "name": "Leanne Graham",
            "username": "Bret",
            "email": "Sincere@april.biz",
            "address": {
              "street": "Kulas Light",
              "suite": "Apt. 556",
              "city": "Gwenborough",
              "zipcode": "92998-3874",
              "geo": { "lat": "-37.3159", "lng": "81.1496" }
            },
            "phone": "1-770-736-8031 x56442",
            "website": "hildegard.org",
            "company": { "name": "Romaguera-Crona", "catchPhrase": "Multi-layered client-server neural-net", "bs": "harness real-time e-markets" }
          }
        ]
        """
        let responseData = Data(expectedJSON.utf8)

        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)!
            return (response, responseData)
        }

        let expectation = XCTestExpectation(description: "Fetch users from mock")
        networkManager.request(.users) { (result: Result<[UserList], NetworkError>) in
            switch result {
            case .success(let users):
                XCTAssertEqual(users.count, 1)
                XCTAssertEqual(users.first?.username, "Bret")
            case .failure(let error):
                XCTFail("Expected success but got error: \(error)")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testRequest_Failure() {
        MockURLProtocol.requestHandler = { _ in
            throw NetworkError.decodingError
        }

        let expectation = XCTestExpectation(description: "Fetch users failure")
        networkManager.request(.users) { (result: Result<[UserList], NetworkError>) in
            switch result {
            case .success:
                XCTFail("Should have failed but succeeded!")
            case .failure(let error):
                XCTAssertEqual(error, .decodingError)
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }
}
