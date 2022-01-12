//
//  SearchUserResponse.swift
//  SpeerTechnologiesAssignment
//
//  Created by Hassan Aftab on 11/01/2022.
//

/// Response for retriving user
struct SearchUserResponse: Codable {
    let user: User?
    let noUserFound: NoUserFoundResponse?

    // Implementing the decoder method  to parse object from root level
    init(from decoder: Decoder) throws {
        do {
            user = try decoder.singleValueContainer().decode(User.self)
            noUserFound = nil
        }
        catch {
            user = nil
            noUserFound = try decoder.singleValueContainer().decode(NoUserFoundResponse.self)
        }
    }
}
