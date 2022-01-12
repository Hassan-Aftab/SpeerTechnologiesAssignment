//
//  GetManufacturerListAPI.swift
//  SpeerTechnologiesAssignment
//
//  Created by Hassan Aftab on 11/01/2022.
//

import Foundation

struct SearchUserRequest: GithubAPI {


    var baseURLProvider: APIURLProvider
    var path: String { "users/" }

    var fullURL: String {
        baseURLProvider.baseURL + path + name
    }

    private let name: String
    var parameters: [String : String]

    init(baseUrlProvider: APIURLProvider = DefaultAPIURLProvider(),
         username: String) {
        self.name = username
        self.baseURLProvider = baseUrlProvider
        parameters = [:]
    }
}
