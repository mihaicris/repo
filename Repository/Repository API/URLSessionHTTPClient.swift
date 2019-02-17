//
//  URLSessionHTTPClient.swift
//  Repository
//
//  Created by Mihai Cristescu on 17/02/2019.
//  Copyright © 2019 Mihai Cristescu. All rights reserved.
//

import Foundation

public class URLSessionHTTPClient: HTTPClient {
    
    // MARK: - Properties
    
    private let session: URLSession
    private struct UnexpectedValuesRepresentation: Error {}
    
    // MARK: - Initialization
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    // MARK: - Public
    
    public func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void) {
        session.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                } else if let data = data, let response = response as? HTTPURLResponse {
                    completion(.success(data, response))
                } else {
                    completion(.failure(UnexpectedValuesRepresentation()))
                }
            }
        }.resume()
    }
    
    // MARK: - Helpers
}
