//
//  UserDetailViewController.swift
//  SpeerTechnologiesAssignment
//
//  Created by Hassan Aftab on 12/01/2022.
//

import UIKit
import IHProgressHUD
import Kingfisher

/// Shows user details
class UserDetailViewController: UIViewController {


    //MARK: properties
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var followersCountButton: UIButton!
    @IBOutlet var followingCountButton: UIButton!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var userView: UIView!

    var user: User?
    var viewModel = UserDetailViewModel()

    //MARK: VC Lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()

        userView.isHidden = true
        bindViews()
        self.title = "Details"
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let user = user {
            viewModel.input.viewDidAppear?(user)
        }
    }

    //MARK: Event Handling
    func bindViews() {

        imageView.layer.cornerRadius = imageView.frame.height/2

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
                self.userView.isHidden = false
                self.showUser(user)
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

}



