//
//  GithubAPI.swift
//  SpeerTechnologiesAssignment
//
//  Created by Hassan Aftab on 11/01/2022.
//

protocol GithubAPI {

    var baseURLProvider: APIURLProvider { get set }
    var path: String { get }
    var fullURL: String { get }
}
