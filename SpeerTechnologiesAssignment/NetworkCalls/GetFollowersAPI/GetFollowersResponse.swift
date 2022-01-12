//
//  SearchUserResponse.swift
//  SpeerTechnologiesAssignment
//
//  Created by Hassan Aftab on 11/01/2022.
//

/// Response for Get followers api
struct GetFollowersResponse: Codable {
    let followers: [User]?

    init(from decoder: Decoder) throws {
        followers = try decoder.singleValueContainer().decode([User].self)
    }

}
