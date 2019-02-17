//
//  FileContentLoader.swift
//  Repository
//
//  Created by Mihai Cristescu on 17/02/2019.
//  Copyright © 2019 Mihai Cristescu. All rights reserved.
//

import Foundation

public enum FileContentLoaderResult {
    case success(File)
    case failure(Error)
}

public protocol FileContentLoader {
    func load(completion: @escaping (FileContentLoaderResult) -> Void)
}
