//
//  FileMapper.swift
//  Repository
//
//  Created by Mihai Cristescu on 17/02/2019.
//  Copyright © 2019 Mihai Cristescu. All rights reserved.
//

import Foundation

internal final class FileMapper {

    private static var OK_200: Int { return 200 }
    
    internal static func map(_ data: Data, from response: HTTPURLResponse) -> RemoteFileContentLoader.Result {
        let jsonDecoder = JSONDecoder()
        
        guard response.statusCode == OK_200,
            let file = try? jsonDecoder.decode(File.self, from: data) else {
                return .failure(RemoteFileContentLoader.Error.invalidData)
        }
        
        return .success(file)
    }
}
