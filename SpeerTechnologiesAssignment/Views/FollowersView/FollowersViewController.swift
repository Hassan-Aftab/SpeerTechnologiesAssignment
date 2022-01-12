//
//  FollowersViewController.swift
//  SpeerTechnologiesAssignment
//
//  Created by Hassan Aftab on 11/01/2022.
//

import UIKit
import IHProgressHUD
import Kingfisher
import SwiftUI

class FollowersViewController: UIViewController {

    //MARK: Properties
    @IBOutlet var collectionView: UICollectionView!
    
    private var users: [User]?
    public var viewModel: FollowersViewModel?

    //MARK: VC Lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        let collectionLayout = UICollectionViewFlowLayout()
        let width = (view.frame.width/2)-40
        collectionLayout.itemSize = CGSize(width: width, height: width)
        collectionView.collectionViewLayout = collectionLayout
        bindViews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel?.input.viewDidAppear?()
        self.title = "Followers"
    }

    /// Bind views to send/receive events
    func bindViews() {

        viewModel?.output.setLoaderHidden = {
            if $0 {
                DispatchQueue.main.async {
                    IHProgressHUD.dismiss()
                }
            }
            else {
                IHProgressHUD.show()
            }
        }
        viewModel?.output.showFollowers = { users in
            self.users = users
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        viewModel?.output.onError = { error in
            DispatchQueue.main.async {
                self.showErrorMessage(error.localizedDescription)
            }
        }
        viewModel?.output.showUserDetail = {
            self.showUserDetail(for: $0)
        }
    }

    //MARK: Presentation Logic
    func showErrorMessage(_ message: String) {
        let dialog = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        dialog.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        self.present(dialog, animated: true, completion: nil)
    }
    func showUserDetail(for user: User?) {
        guard let user = user,
              let vc = UserDetailViewControllerBuilder.build() else { return }
        vc.user = user
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: UICollectionView Delegate/DataSource
extension FollowersViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        users?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "followerCell", for: indexPath) as? FollowerFollowingCell else {
            return UICollectionViewCell()
        }

        guard let user = users?[indexPath.item] else { return cell }
        cell.setup(user)
        cell.didTap = { [weak self] in
            self?.viewModel?.input.didSelect?(user)
        }
        return cell
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 30, bottom: 0, right: 30)
    }
}

