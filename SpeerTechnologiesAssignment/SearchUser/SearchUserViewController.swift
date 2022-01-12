//
//  ViewController.swift
//  SpeerTechnologiesAssignment
//
//  Created by Hassan Aftab on 11/01/2022.
//

import UIKit

class SearchUserViewController: UIViewController {

    @IBOutlet var searchBar: UISearchBar!
    var searchBarInteractor: SearchUserSearchBarInteractorType = SearchUserSearchBarInteractor()
    let viewModel = SearchUserViewModel()

    lazy var searchBarDelegate: SearchUserSearchBarDelegate = {
        SearchUserSearchBarDelegate(searchBarInteractor)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = searchBarDelegate
        bindViews()
    }

    func bindViews() {


        searchBarInteractor.onSearchTapped = {
            self.viewModel.input.search?($0)
        }
        searchBarInteractor.onBeginEditing = {
            self.viewModel.input.searchBarBeginEditing?()
        }
        searchBarInteractor.onEndEditing = {
            self.viewModel.input.searchBarEndEditing?()
        }
        searchBarInteractor.onCancel = {
            self.viewModel.input.searchBarCancel?()
        }

        viewModel.output.showSearchBarCancelButton = {
            self.searchBar.setShowsCancelButton($0, animated: true)
        }
        viewModel.output.clearSearchBar = {
            self.searchBar.text = ""
        }
        viewModel.output.resignSearchBar = {
            self.searchBar.resignFirstResponder()
        }

    }
}



