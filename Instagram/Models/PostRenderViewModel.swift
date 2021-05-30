//
//  PostRenderViewModel.swift
//  Instagram
//
//  Created by Punreach Rany on 2021/05/30.
//

import Foundation

/// States of rendered cell
enum PostRenderType {
    case header(provider: User)
    case primaryContent(provider: UserPost) // post
    case actions(provider: String) // like, comment, share
    case comments(comments: [PostComment])
}

/// Model of render post
public struct PostRenderViewModel {
    let renderType: PostRenderType
}
