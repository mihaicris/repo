//
//  RepoResult.swift
//  Repository
//
//  Created by Mihai Cristescu on 17/02/2019.
//  Copyright © 2019 Mihai Cristescu. All rights reserved.
//

import Foundation

public struct Owner: Decodable{
    public let login: String
}

public struct Repository: Decodable {
    public let name: String
    public let fullName: String
    public let owner: Owner
    public let description: String
    public let url: URL
    public let stargazersCount: Int
    public let watchersCount: Int
    public let forksCount: Int
}

public struct SearchResult: Decodable {
    public let items: [Repository]
}
