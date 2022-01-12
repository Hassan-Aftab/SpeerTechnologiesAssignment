//
//  APIBaseURLProvider.swift
//  SpeerTechnologiesAssignment
//
//  Created by Hassan Aftab on 11/01/2022.
//

import Foundation

protocol APIURLProvider {
    var baseURL : String { get }
}

struct DefaultAPIURLProvider: APIURLProvider {
    var baseURL: String { "https://api.github.com/" }
}
