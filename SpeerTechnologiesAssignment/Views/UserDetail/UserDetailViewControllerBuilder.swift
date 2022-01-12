//
//  UserDetailViewControllerBuilder.swift
//  SpeerTechnologiesAssignment
//
//  Created by Hassan Aftab on 12/01/2022.
//

import UIKit

class UserDetailViewControllerBuilder {
    class func build() -> UserDetailViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "UserDetailViewController") as? UserDetailViewController
    }
}
