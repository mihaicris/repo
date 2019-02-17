//
//  RepositoryMapper.swift
//  Repository
//
//  Created by Mihai Cristescu on 17/02/2019.
//  Copyright © 2019 Mihai Cristescu. All rights reserved.
//

import Foundation

internal final class RepositoryItemsMapper {
    private struct Root: Decodable {
        let items: [Repository]
    }
    
    private static var OK_200: Int { return 200 }
    
    internal static func map(_ data: Data, from response: HTTPURLResponse) -> RemoteRepositoryLoader.Result {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard response.statusCode == OK_200,
            let root = try? jsonDecoder.decode(Root.self, from: data) else {
                return .failure(RemoteRepositoryLoader.Error.invalidData)
        }
        
        return .success(root.items)
    }
}
