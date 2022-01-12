//
//  SearchUserSearchBarDelegate.swift
//  SpeerTechnologiesAssignment
//
//  Created by Hassan Aftab on 12/01/2022.
//

import UIKit

class SearchUserSearchBarDelegate: NSObject, UISearchBarDelegate {

    var interactor: SearchUserSearchBarInteractorType

    init(_ interactor: SearchUserSearchBarInteractorType) {
        self.interactor = interactor
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        interactor.onBeginEditing?()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        interactor.onCancel?()
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        interactor.onEndEditing?()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        interactor.onSearchTapped?(searchBar.text ?? "")
    }

}
