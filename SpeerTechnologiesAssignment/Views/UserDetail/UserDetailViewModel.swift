//
//  UserDetailViewModel.swift
//  SpeerTechnologiesAssignment
//
//  Created by Hassan Aftab on 12/01/2022.
//

import Foundation

class UserDetailViewModel {

    //MARK: Input/Output Events
    struct Input {
        var viewDidAppear: ((User)->())?
    }

    struct Output {
        var onError: ((Error)->())?
        var showUser: ((User)->())?
        var setLoaderHidden: ((Bool)->())?
    }

    //MARK: Properties
    var input = Input()
    var output = Output()

    private let searchUserService: SearchUserHandler!

    //MARK: Init
    init(_ searchUserService: SearchUserHandler = SearchUserHandlerService()) {
        self.searchUserService = searchUserService

        input.viewDidAppear = {
            self.getDetails($0.username)
            self.output.setLoaderHidden?(false)
        }

    }

    //MARK: API Call
    func getDetails(_ username: String) {
        searchUserService.searchUser(username: username) { res in
            self.output.setLoaderHidden?(true)
            switch res {
            case .failure(let error):
                self.output.onError?(error)
            case .success(let userResponse):
                if let user = userResponse.user {
                    self.output.showUser?(user)
                }
            }
        }
    }
}
