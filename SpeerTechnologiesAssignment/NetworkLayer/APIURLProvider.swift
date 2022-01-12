//
//  APIBaseURLProvider.swift
//  SpeerTechnologiesAssignment
//
//  Created by Hassan Aftab on 11/01/2022.
//

import Foundation

/// Provides base url to be used across different services
protocol APIURLProvider {
    var baseURL : String { get }
}

/// Default implementation of url provider
struct DefaultAPIURLProvider: APIURLProvider {
    var baseURL: String { "https://api.github.com/" }
}
