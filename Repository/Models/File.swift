//
//  Root.swift
//  Repository
//
//  Created by Mihai Cristescu on 17/02/2019.
//  Copyright © 2019 Mihai Cristescu. All rights reserved.
//

import Foundation

public struct File: Codable {
    public let type: String
    public let size: Int
    public let name: String
    public let content: String
    public let downloadURL: URL
    
    enum CodingKeys: String, CodingKey {
        case type
        case size
        case name
        case content
        case downloadURL = "download_url"
    }
    
    public var contentString: String? {
        return content.fromBase64()
    }
}
