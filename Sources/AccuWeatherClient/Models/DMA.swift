//
//  DMA.swift
//  AccuWeatherClient
//
//  Created by Arsha Hassas on 7/1/20.
//

import Foundation

// MARK: - DMA
public struct DMA: Codable {
    public let id: Int?
    public let englishName: String

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case englishName = "EnglishName"
    }

    public init(id: Int, englishName: String) {
        self.id = id
        self.englishName = englishName
    }
}
