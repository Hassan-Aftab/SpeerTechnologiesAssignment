//
//  FollowerFollowingCell.swift
//  SpeerTechnologiesAssignment
//
//  Created by Hassan Aftab on 12/01/2022.
//

import UIKit
import Kingfisher

class FollowerFollowingCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var username: UILabel!

    var didTap: (()->())?
    func setup(_ user: User) {
        imageView.layer.cornerRadius = imageView.frame.width/2
        imageView.kf.setImage(with: URL(string: user.avatarUrl))
        username.text = user.username

        self.contentView.layer.borderColor = UIColor.lightGray.cgColor
        self.contentView.layer.borderWidth = 1
    }
    @IBAction func didSelect(_ sender: Any) {
        didTap?()
    }
}
