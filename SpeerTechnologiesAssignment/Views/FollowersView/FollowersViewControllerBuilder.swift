//
//  FollowersViewControllerBuilder.swift
//  SpeerTechnologiesAssignment
//
//  Created by Hassan Aftab on 12/01/2022.
//

import UIKit

class FollowersViewControllerBuilder {
    class func build() -> FollowersViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "FollowersViewController") as? FollowersViewController
    }
}
