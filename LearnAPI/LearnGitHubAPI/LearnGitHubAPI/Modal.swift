//
//  Modal.swift
//  LearnGitHubAPI
//
//  Created by Thiago Pereira de Menezes on 16/08/23.
//

import Foundation

struct GitHubUser: Codable, Hashable {
    let login: String
    let avatarUrl: String
    let bio: String?
}

enum GHError: Error {
    case invalidURL
    case invalidResponce
    case invalidData
}
