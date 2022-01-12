//
//  User.swift
//  SpeerTechnologiesAssignment
//
//  Created by Hassan Aftab on 12/01/2022.
//

/// Model for User/Follower
struct User: Codable {
    let username: String
    let id: Int64
    let avatarUrl: String
    let profileApiUrl: String
    let profileUrl: String
    let followersUrl: String
    let followingUrl: String
    let name: String?
    let bio: String?
    let followers: Int?
    let following: Int?

    enum CodingKeys: String, CodingKey {
        case id, name, bio, followers, following
        case username = "login"
        case avatarUrl = "avatar_url"
        case profileApiUrl = "url"
        case profileUrl = "html_url"
        case followersUrl = "followers_url"
        case followingUrl = "following_url"

    }
}
