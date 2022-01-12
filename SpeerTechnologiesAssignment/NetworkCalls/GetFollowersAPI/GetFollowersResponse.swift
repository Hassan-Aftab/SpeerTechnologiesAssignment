//
//  SearchUserResponse.swift
//  SpeerTechnologiesAssignment
//
//  Created by Hassan Aftab on 11/01/2022.
//

struct GetFollowersResponse: Codable {
    let followers: [User]?

    init(from decoder: Decoder) throws {
        followers = try decoder.singleValueContainer().decode([User].self)
    }

}
