//
//  ViewController.swift
//  SpeerTechnologiesAssignment
//
//  Created by Hassan Aftab on 11/01/2022.
//

import UIKit
import IHProgressHUD
import Kingfisher
import SwiftUI

class SearchUserViewController: UIViewController {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var followersCountButton: UIButton!
    @IBOutlet var followingCountButton: UIButton!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var userView: UIView!

    @IBOutlet var errorView: UIView!
    var noUserFoundView = NoUserFoundBuilder.build()
    var searchBarInteractor: SearchUserSearchBarInteractorType = SearchUserSearchBarInteractor()
    let viewModel = SearchUserViewModel()
    lazy var searchBarDelegate: SearchUserSearchBarDelegate = {
        SearchUserSearchBarDelegate(searchBarInteractor)
    }()

    private var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()

        errorView.isHidden = true
        userView.isHidden = true
        searchBar.delegate = searchBarDelegate
        setupSubviews()
        bindViews()
    }

    func setupSubviews() {
        errorView.addSubview(noUserFoundView)
        noUserFoundView.translatesAutoresizingMaskIntoConstraints = false
        errorView.leftAnchor.constraint(equalTo: noUserFoundView.leftAnchor).isActive = true
        errorView.rightAnchor.constraint(equalTo: noUserFoundView.rightAnchor).isActive = true
        errorView.topAnchor.constraint(equalTo: noUserFoundView.topAnchor).isActive = true
        errorView.bottomAnchor.constraint(equalTo: noUserFoundView.bottomAnchor).isActive = true
        self.view.layoutIfNeeded()
    }

    func bindViews() {

        imageView.layer.cornerRadius = imageView.frame.height/2
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

        viewModel.output.setLoaderHidden = {
            if $0 {
                DispatchQueue.main.async {
                    IHProgressHUD.dismiss()
                }
            }
            else {
                IHProgressHUD.show()
            }
        }
        viewModel.output.showUser = { user in
            self.user = user
            DispatchQueue.main.async {
                self.errorView.isHidden = true
                self.userView.isHidden = false
                self.showUser(user)
            }
        }
        viewModel.output.userNotFound = {
            self.user = nil
            DispatchQueue.main.async {
                self.userView.isHidden = true
                self.errorView.isHidden = false
            }
        }
        viewModel.output.onError = { error in
            DispatchQueue.main.async {
                self.showErrorMessage(error.localizedDescription)
            }
        }
    }
    func showErrorMessage(_ message: String) {
        let dialog = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        dialog.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        self.present(dialog, animated: true, completion: nil)
    }
    private func showUser(_ user: User) {
        self.imageView.kf.setImage(with: URL(string: user.avatarUrl))
        self.nameLabel.text = user.name
        self.usernameLabel.text = user.username
        self.followersCountButton.setTitle(String(user.followers ?? 0) + " followers", for: .normal)
        self.followingCountButton.setTitle(String(user.following ?? 0) + " followings", for: .normal)
        self.descriptionTextView.text = user.bio
    }
    @IBAction func followerCountButtonPressed(_ sender: Any) {
        guard let user = user else {
            return
        }
        guard let vc = FollowersViewControllerBuilder.build() else {
            return
        }
        vc.viewModel = FollowersViewModel(GetFollowersHandlerService(), user.username)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func followingCountButtonPressed(_ sender: Any) {
        guard let user = user else {
            return
        }
        guard let vc = FollowersViewControllerBuilder.build() else {
            return
        }
        vc.viewModel = FollowersViewModel(GetFollowersHandlerService(), user.username)
        self.navigationController?.pushViewController(vc, animated: true)
    }

}



