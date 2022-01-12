//
//  GetFollowersHandler.swift
//  SpeerTechnologiesAssignment
//
//  Created by Hassan Aftab on 11/01/2022.
//

protocol GetFollowersHandler {
    func getCarList(username: String, completion: @escaping CompletionHandler<GetFollowersResponse>)
}

class GetFollowersHandlerService: GetFollowersHandler {
    let networkService: NetworkService

    init(networkService: NetworkService = DefaultNetworkService()) {
        self.networkService = networkService
    }

    func getCarList(username: String,
                    completion: @escaping CompletionHandler<GetFollowersResponse>){

        let request = GetFollowersRequest(username: username)
        networkService.sendGetRequest(request, completion: completion)
    }
}
