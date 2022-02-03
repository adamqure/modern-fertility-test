//
//  SocialPost.swift
//  Modern Fertility Assessment
//
//  Created by Adam Ure on 2/2/22.
//

import Foundation

struct SocialPost: Hashable, Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
