//
//  AdministrativeArea.swift
//  WeatherClient
//
//  Created by Arsha Hassas on 6/27/20.
//

import Foundation


// MARK: - AdministrativeArea
public struct AdministrativeArea: Codable {
    public let id, localizedName, englishName: String
    public let level: Int?
    public let localizedType, englishType, countryId: String

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case localizedName = "LocalizedName"
        case englishName = "EnglishName"
        case level = "Level"
        case localizedType = "LocalizedType"
        case englishType = "EnglishType"
        case countryId = "CountryID"
    }

    public init(id: String, localizedName: String, englishName: String, level: Int, localizedType: String, englishType: String, countryId: String) {
        self.id = id
        self.localizedName = localizedName
        self.englishName = englishName
        self.level = level
        self.localizedType = localizedType
        self.englishType = englishType
        self.countryId = countryId
    }
}
