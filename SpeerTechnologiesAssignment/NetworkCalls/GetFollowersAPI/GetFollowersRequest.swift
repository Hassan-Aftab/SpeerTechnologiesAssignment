//
//  GetFollowersRequest.swift
//  SpeerTechnologiesAssignment
//
//  Created by Hassan Aftab on 11/01/2022.
//

import Foundation

/// Request for fetching followers
struct GetFollowersRequest: GithubAPI {

    var baseURLProvider: APIURLProvider
    var path: String { String(format: "users/%@/followers", username) }

    var fullURL: String {
        baseURLProvider.baseURL + path
    }
    private let username: String

    init(baseUrlProvider: APIURLProvider = DefaultAPIURLProvider(),
         username: String) {
        self.baseURLProvider = baseUrlProvider
        self.username = username
    }
}
