//
//  RepositoryListLoader.swift
//  Repository
//
//  Created by Mihai Cristescu on 17/02/2019.
//  Copyright © 2019 Mihai Cristescu. All rights reserved.
//

import Foundation

public enum LoadRepositoryListResult {
    case success([Repository])
    case failure(Error)
}

public protocol RepositoryListLoader {
    func load(completion: @escaping (LoadRepositoryListResult) -> Void)
}
