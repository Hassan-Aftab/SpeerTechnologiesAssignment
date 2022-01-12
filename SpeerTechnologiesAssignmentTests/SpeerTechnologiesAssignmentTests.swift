//
//  SpeerTechnologiesAssignmentTests.swift
//  SpeerTechnologiesAssignmentTests
//
//  Created by Hassan Aftab on 11/01/2022.
//

import XCTest
@testable import SpeerTechnologiesAssignment

class SearchUserViewModelTests: XCTestCase {

    var mockService: SearchUserHandler!
    var viewModel: SearchUserViewModel!
    override func setUpWithError() throws {
        mockService = MockSearchUserAPI()
        viewModel = SearchUserViewModel(mockService)
    }

    override func tearDownWithError() throws {
        mockService = nil
        viewModel = nil
    }

    func testSearchBarBeginEditing() throws {

        var events = 0

        // Given Event Listener
        viewModel.output.showSearchBarCancelButton = { _ in
            events += 1
        }

        // When Event is triggerd
        viewModel.input.searchBarBeginEditing?()

        // Event Count increases
        XCTAssertEqual(events, 1)
    }

    func testSearchBarEndEditing() throws {

        var events = 0

        // Given Event Listener
        viewModel.output.showSearchBarCancelButton = { _ in
            events += 1
        }

        // When Event is triggerd
        viewModel.input.searchBarEndEditing?()

        // Event Count increases
        XCTAssertEqual(events, 1)
    }

    func testSearchBarCancel() throws {
        var events = 0

        // Given 3 Event Listeners
        viewModel.output.showSearchBarCancelButton = { _ in
            events += 1
        }

        viewModel.output.clearSearchBar = {
            events += 1
        }

        viewModel.output.resignSearchBar = {
            events += 1
        }

        // When Event is triggerd
        viewModel.input.searchBarCancel?()

        // Event Count increases
        XCTAssertEqual(events, 3)
    }

    func testSearchSuccess() {
        var events = 0
        var user : User?

        viewModel.output.setLoaderHidden = { _ in
            events += 1
        }

        viewModel.output.showSearchBarCancelButton = { _ in
            events += 1
        }

        viewModel.output.showUser = { response in
            user = response
        }

        viewModel.input.search?("Hassan-Aftab")

        XCTAssertEqual(events, 3)
        XCTAssertNotNil(user)
        XCTAssertEqual(user?.username, "Hassan-Aftab")
        XCTAssertEqual(user?.name, "Hassan Aftab")
    }

    func testSearchNoUserFound() {
        var events = 0

        viewModel.output.setLoaderHidden = { _ in // called twice
            events += 1
        }
        viewModel.output.showSearchBarCancelButton = { _ in
            events += 1
        }
        viewModel.output.userNotFound = {
            events += 1
        }

        viewModel.input.search?("Hassan")

        XCTAssertEqual(events, 4)
    }

    func testSearchError() {
        var events = 0
        var error: Error?

        viewModel.output.setLoaderHidden = { _ in // called twice
            events += 1
        }
        viewModel.output.showSearchBarCancelButton = { _ in
            events += 1
        }
        viewModel.output.onError = { err in
            events += 1
            error = err
        }

        viewModel.input.search?("-")

        XCTAssertEqual(events, 4)
        XCTAssert(error is MockError)
    }
}

class MockSearchUserAPI: SearchUserHandler {
    func searchUser(username: String, completion: @escaping CompletionHandler<SearchUserResponse>) {
        if username == "-" {
            completion(.failure(MockError.invalidInput))
            return
        }
        if username == "Hassan-Aftab" {

            completion(.success(MockUserResponse.getMockUser()))
            return
        }
        completion(.success(MockUserResponse.getMockNoUserFound()))
    }
}

class MockUserResponse {
    static func getMockUser() -> SearchUserResponse {
        let url = URL(fileURLWithPath: Bundle(for: type(of: MockUserResponse())).path(forResource: "MockUser", ofType: "json")!)
        let data = try! Data(contentsOf: url)
        return try! JSONDecoder().decode(SearchUserResponse.self, from: data)
    }

    static func getMockNoUserFound() -> SearchUserResponse {
        let url = URL(fileURLWithPath: Bundle(for: type(of: MockUserResponse())).path(forResource: "MockNoUserFound", ofType: "json")!)
        let data = try! Data(contentsOf: url)
        return try! JSONDecoder().decode(SearchUserResponse.self, from: data)
    }
}

enum MockError: Error {
    case invalidInput
}
