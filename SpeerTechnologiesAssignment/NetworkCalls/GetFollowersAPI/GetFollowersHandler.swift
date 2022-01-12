//
//  GetFollowersHandler.swift
//  SpeerTechnologiesAssignment
//
//  Created by Hassan Aftab on 11/01/2022.
//

/// Protocol for fetching the followers
protocol GetFollowersHandler {
    func getUsers(username: String, completion: @escaping CompletionHandler<GetFollowersResponse>)
}

/// Get Followers Service
class GetFollowersHandlerService: GetFollowersHandler {
    let networkService: NetworkService

    init(networkService: NetworkService = DefaultNetworkService()) {
        self.networkService = networkService
    }

    func getUsers(username: String,
                    completion: @escaping CompletionHandler<GetFollowersResponse>){

        let request = GetFollowersRequest(username: username)
        networkService.sendGetRequest(request, completion: completion)
    }
}
