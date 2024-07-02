//
//  Post.swift
//  FastAPIPractice
//
//  Created by 신승재 on 7/2/24.
//

import Foundation

struct Post: Codable {
    let date: String
    let title: String
    let content: String
    let author_id: String
    let id: String
}
