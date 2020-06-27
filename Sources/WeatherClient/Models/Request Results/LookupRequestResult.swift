//
//  LookupRequestResult.swift
//  WeatherClient
//
//  Created by Arsha Hassas on 6/25/20.
//

import Foundation

struct LookupRequestResult: Codable {
    
    struct RequestInfo: Codable {
        let query: String
        let resultsCount: Int
        
        enum CodingKeys: String, CodingKey {
            case query, resultsCount = "results"
        }
    }
    
    let requestInfo: RequestInfo
    let results: [Location]
}
