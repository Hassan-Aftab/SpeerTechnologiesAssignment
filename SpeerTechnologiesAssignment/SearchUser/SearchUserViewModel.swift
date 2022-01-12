//
//  SearchUserViewModel.swift
//  SpeerTechnologiesAssignment
//
//  Created by Hassan Aftab on 11/01/2022.
//

import Foundation
import UIKit

class SearchUserViewModel {
    struct Input {
        var searchBarBeginEditing: (()->())?
        var searchBarEndEditing: (()->())?
        var searchBarCancel: (()->())?
        var search: ((String)->())?
        var getFollowers: ((User)->())?
    }

    struct Output {
        var showSearchBarCancelButton: ((Bool)->())?
        var setLoaderHidden: ((Bool)->())?
        var clearSearchBar: (()->())?
        var resignSearchBar: (()->())?
        var onError: ((Error)->())?
        var userNotFound: (()->())?
        var showUser: ((User)->())?
        var onToFollowers: ((User)->())?
    }

    var input = Input()
    var output = Output()

    private let searchUserService: SearchUserHandler!
    init(_ searchUserService: SearchUserHandler = SearchUserHandlerService()) {
        self.searchUserService = searchUserService

        input.search = {
            self.search($0)
            self.output.setLoaderHidden?(false)
            self.output.showSearchBarCancelButton?(false)
            self.output.resignSearchBar?()
        }

        input.searchBarBeginEditing = {
            self.output.showSearchBarCancelButton?(true)
        }

        input.searchBarEndEditing = {
            self.output.showSearchBarCancelButton?(false)
        }

        input.searchBarCancel = {
            self.output.showSearchBarCancelButton?(false)
            self.output.clearSearchBar?()
            self.output.resignSearchBar?()
        }
    }

    func search(_ username: String) {
        searchUserService.searchUser(username: username) { res in
            self.output.setLoaderHidden?(true)
            switch res {
            case .failure(let error):
                self.output.onError?(error)
            case .success(let userResponse):
                if let user = userResponse.user {
                    self.output.showUser?(user)
                }
                else if userResponse.noUserFound != nil {
                    self.output.userNotFound?()
                }
            }
        }
    }
}
