//
//  UserNotification.swift
//  Instagram
//
//  Created by Punreach Rany on 2021/05/30.
//

import Foundation

enum UserNotificationType {
    case like(post: UserPost)
    case follow(state: FollowState)
}

struct UserNotification {
    let type: UserNotificationType
    let text: String
    let user: User
}


