//
//  SupplementalArea.swift
//  WeatherClient
//
//  Created by Arsha Hassas on 6/27/20.
//

import Foundation

// MARK: - SupplementalAdminArea
public struct SupplementalAdminArea: Codable, Hashable {
    public let level: Int?
    public let localizedName: String
    public let englishName: String

    enum CodingKeys: String, CodingKey {
        case level = "Level"
        case localizedName = "LocalizedName"
        case englishName = "EnglishName"
    }

    public init(level: Int, localizedName: String, englishName: String) {
        self.level = level
        self.localizedName = localizedName
        self.englishName = englishName
    }
}
