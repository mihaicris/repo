//
//  Root.swift
//  Repository
//
//  Created by Mihai Cristescu on 17/02/2019.
//  Copyright © 2019 Mihai Cristescu. All rights reserved.
//

import Foundation

struct Owner: Decodable{
    let login: String
}

struct RepoResult: Decodable {
    let name: String
    let fullName: String
    let owner: Owner
    let description: String
    let url: URL
    let stargazersCount: Int
    let watchersCount: Int
    let forksCount: Int
}

struct SearchResult: Decodable {
    let items: [RepoResult]
}

struct File: Codable {
    let type: String
    let size: Int
    let name: String
    let content: String
    let downloadURL: URL
    
    enum CodingKeys: String, CodingKey {
        case type
        case size
        case name
        case content
        case downloadURL = "download_url"
    }
    
    var contentString: String? {
        return content.fromBase64()
    }
}

