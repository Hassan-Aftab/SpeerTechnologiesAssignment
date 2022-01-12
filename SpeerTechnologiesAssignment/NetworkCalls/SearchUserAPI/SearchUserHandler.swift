//
//  SearchUserHandler.swift
//  SpeerTechnologiesAssignment
//
//  Created by Hassan Aftab on 11/01/2022.
//

/// Protocol for Search User Service
protocol SearchUserHandler {
    func searchUser(username: String, completion: @escaping CompletionHandler<SearchUserResponse>)
}

/// Search User Service
class SearchUserHandlerService: SearchUserHandler {
    let networkService: NetworkService

    init(networkService: NetworkService = DefaultNetworkService()) {
        self.networkService = networkService
    }

    func searchUser(username: String,
                             completion: @escaping CompletionHandler<SearchUserResponse>){

        let request = SearchUserRequest(username: username)
        networkService.sendGetRequest(request, completion: completion)
    }
}
