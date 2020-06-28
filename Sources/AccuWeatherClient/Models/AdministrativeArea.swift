//
//  AdministrativeArea.swift
//  WeatherClient
//
//  Created by Arsha Hassas on 6/27/20.
//

import Foundation

// MARK: - AdministrativeArea
public struct AdministrativeArea: Codable, Hashable {
    public let id: String
    public let localizedName: String
    public let englishName: String
    public let level: Int?
    public let localizedType: String
    public let englishType: String
    public let countryID: String

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case localizedName = "LocalizedName"
        case englishName = "EnglishName"
        case level = "Level"
        case localizedType = "LocalizedType"
        case englishType = "EnglishType"
        case countryID = "CountryID"
    }

    public init(id: String, localizedName: String, englishName: String, level: Int, localizedType: String, englishType: String, countryID: String) {
        self.id = id
        self.localizedName = localizedName
        self.englishName = englishName
        self.level = level
        self.localizedType = localizedType
        self.englishType = englishType
        self.countryID = countryID
    }
}
