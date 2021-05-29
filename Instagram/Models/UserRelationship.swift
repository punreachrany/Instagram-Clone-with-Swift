//
//  UserFollowState.swift
//  Instagram
//
//  Created by elite on 2021/05/24.
//

import Foundation

enum FollowState {
    case following, not_following
}

struct UserRelationship {
    let username: String
    let name: String
    let type: FollowState
}
