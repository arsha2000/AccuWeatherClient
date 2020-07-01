//
//  Country.swift
//  WeatherClient
//
//  Created by Arsha Hassas on 6/27/20.
//

import Foundation

// MARK: - Country
public struct Country: Codable {
    public let id, localizedName, englishName: String

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case localizedName = "LocalizedName"
        case englishName = "EnglishName"
    }

    public init(id: String, localizedName: String, englishName: String) {
        self.id = id
        self.localizedName = localizedName
        self.englishName = englishName
    }
}
