//
//  NoUserFoundBuilder.swift
//  SpeerTechnologiesAssignment
//
//  Created by Hassan Aftab on 12/01/2022.
//

import Foundation
import UIKit

/// Builds and returns view when user is not found
class NoUserFoundBuilder {
    static func build() -> NoUserFoundView {
        UINib(nibName: "NoUserFoundView", bundle: nil)
            .instantiate(withOwner: nil, options: nil)
            .first as! NoUserFoundView
    }
}
