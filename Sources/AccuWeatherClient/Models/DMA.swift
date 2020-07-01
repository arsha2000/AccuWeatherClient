//
//  DMA.swift
//  AccuWeatherClient
//
//  Created by Arsha Hassas on 7/1/20.
//

import Foundation

// MARK: - DMA
public struct DMA: Codable {
    public let id, englishName: String

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case englishName = "EnglishName"
    }

    public init(id: String, englishName: String) {
        self.id = id
        self.englishName = englishName
    }
}
