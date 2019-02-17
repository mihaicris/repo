//
//  RemoteFileContentLoader.swift
//  Repository
//
//  Created by Mihai Cristescu on 17/02/2019.
//  Copyright © 2019 Mihai Cristescu. All rights reserved.
//

import Foundation

public final class RemoteFileContentLoader: FileContentLoader {
    
    // MARK: - Properties
    
    private let url: URL
    private let client: HTTPClient
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public typealias Result = FileContentLoaderResult
    
    // MARK: - Initializer
    
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    // MARK: - API
    
    public func load(completion: @escaping (Result) -> Void) {
        
        let readmeURL = getReadmeURL(from: url)
        
        client.get(from: readmeURL) { [weak self] result in
            guard self != nil else { return }
            
            switch result {
            case let .success(data, response):
                completion(FileMapper.map(data, from: response))
            case .failure:
                completion(.failure(Error.connectivity))
            }
        }
    }
    
    // MARK: - Helpers
    
    private func getReadmeURL(from url: URL) -> URL {
        return url.appendingPathComponent("readme")
    }
}
