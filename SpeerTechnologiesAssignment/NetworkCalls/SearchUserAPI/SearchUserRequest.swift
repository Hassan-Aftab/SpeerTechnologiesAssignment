//
//  GetManufacturerListAPI.swift
//  SpeerTechnologiesAssignment
//
//  Created by Hassan Aftab on 11/01/2022.
//

import Foundation

/// Request to be sent to search for a user or get user detail
struct SearchUserRequest: GithubAPI {

    var baseURLProvider: APIURLProvider
    var path: String { "users/" }

    // for url request we need to put name within the url
    var fullURL: String {
        baseURLProvider.baseURL + path + name
    }
    private let name: String

    init(baseUrlProvider: APIURLProvider = DefaultAPIURLProvider(),
         username: String) {
        self.name = username
        self.baseURLProvider = baseUrlProvider
    }
}
