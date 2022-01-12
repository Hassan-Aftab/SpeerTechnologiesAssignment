//
//  FollowersViewModel.swift
//  SpeerTechnologiesAssignment
//
//  Created by Hassan Aftab on 11/01/2022.
//

import Foundation
import UIKit

class FollowersViewModel {

    //MARK: Input/Output
    struct Input {
        var viewDidAppear: (()->())?
        var didSelect: ((User)->())?
    }

    struct Output {
        var showFollowers: (([User])->())?
        var setLoaderHidden: ((Bool)->())?
        var onError: ((Error)->())?
        var showUserDetail:((User?)->())?
    }

    //MARK: Properties
    var input = Input()
    var output = Output()

    var username: String?
    private let followerService: GetFollowersHandler!

    //MARK: Init
    init(_ followerService: GetFollowersHandler = GetFollowersHandlerService(),
         _ username: String) {
        self.followerService = followerService
        self.username = username

        input.viewDidAppear = {
            self.output.setLoaderHidden?(false)
            self.getFollowers(username)
        }

        input.didSelect = {
            self.output.showUserDetail?($0)
        }
    }

    //MARK: API call
    func getFollowers(_ username: String) {
        followerService.getUsers(username: username) { res in
            self.output.setLoaderHidden?(true)
            switch res {
            case .failure(let error):
                self.output.onError?(error)
            case .success(let response):
                if let followers = response.followers {
                    self.output.showFollowers?(followers)
                }
            }
        }
    }

}
