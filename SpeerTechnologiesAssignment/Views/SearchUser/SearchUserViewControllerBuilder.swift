//
//  SearchUserViewControllerBuilder.swift
//  SpeerTechnologiesAssignment
//
//  Created by Hassan Aftab on 12/01/2022.
//

import UIKit

class SearchUserViewControllerBuilder {
    class func build() -> SearchUserViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "SearchUserViewController") as? SearchUserViewController
    }
}
