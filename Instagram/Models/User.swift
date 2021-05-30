//
//  User.swift
//  Instagram
//
//  Created by Punreach Rany on 2021/05/23.
//

import Foundation

enum Gender {
    case male, female, other
}
struct User {
    let username: String
    let name: (first: String, last: String)
    let birthDate: Date
    let gender: Gender
    let counts: UserCount
    let joinedDate: Date
    let profilePhoto: URL
}

struct UserCount {
    let followers: Int
    let following: Int
    let posts: Int
}
