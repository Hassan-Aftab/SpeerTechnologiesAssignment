//
//  FollowersViewModel.swift
//  SpeerTechnologiesAssignment
//
//  Created by Hassan Aftab on 11/01/2022.
//

import Foundation
import UIKit

class FollowersViewModel {
    struct Input {
        var viewDidAppear: (()->())?
//        var searchBarEndEditing: (()->())?
//        var searchBarCancel: (()->())?
//        var search: ((String)->())?
//        var getFollowers: ((User)->())?
    }

    struct Output {
        var showFollowers: (([User])->())?
        var setLoaderHidden: ((Bool)->())?
        var onError: ((Error)->())?

    }

    var input = Input()
    var output = Output()

    var username: String?

    private let followerService: GetFollowersHandler!
    init(_ followerService: GetFollowersHandler = GetFollowersHandlerService(),
         _ username: String) {
        self.followerService = followerService
        self.username = username

        input.viewDidAppear = {
            self.output.setLoaderHidden?(false)
            self.getFollowers(username)
        }

    }

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
