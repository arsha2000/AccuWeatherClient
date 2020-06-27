//
//  City.swift
//  WeatherClient
//
//  Created by Arsha Hassas on 6/25/20.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

import Foundation




// MARK: - City
public struct City: Codable, Hashable {
    public let version: Int
    public let key: String
    public let type: String
    public let rank: Int
    public let localizedName: String
    public let englishName: String
    public let primaryPostalCode: String
    public let region: Country
    public let country: Country
    public let administrativeArea: AdministrativeArea
    public let timeZone: TimeZone
    public let geoPosition: GeoPosition
    public let isAlias: Bool
    public let supplementalAdminAreas: [SupplementalAdminArea]
    public let dataSets: [String]

    enum CodingKeys: String, CodingKey {
        case version = "Version"
        case key = "Key"
        case type = "Type"
        case rank = "Rank"
        case localizedName = "LocalizedName"
        case englishName = "EnglishName"
        case primaryPostalCode = "PrimaryPostalCode"
        case region = "Region"
        case country = "Country"
        case administrativeArea = "AdministrativeArea"
        case timeZone = "TimeZone"
        case geoPosition = "GeoPosition"
        case isAlias = "IsAlias"
        case supplementalAdminAreas = "SupplementalAdminAreas"
        case dataSets = "DataSets"
    }

    public init(version: Int, key: String, type: String, rank: Int, localizedName: String, englishName: String, primaryPostalCode: String, region: Country, country: Country, administrativeArea: AdministrativeArea, timeZone: TimeZone, geoPosition: GeoPosition, isAlias: Bool, supplementalAdminAreas: [SupplementalAdminArea], dataSets: [String]) {
        self.version = version
        self.key = key
        self.type = type
        self.rank = rank
        self.localizedName = localizedName
        self.englishName = englishName
        self.primaryPostalCode = primaryPostalCode
        self.region = region
        self.country = country
        self.administrativeArea = administrativeArea
        self.timeZone = timeZone
        self.geoPosition = geoPosition
        self.isAlias = isAlias
        self.supplementalAdminAreas = supplementalAdminAreas
        self.dataSets = dataSets
    }
}

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).



//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).



//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).



//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).



//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).



//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).



//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).



