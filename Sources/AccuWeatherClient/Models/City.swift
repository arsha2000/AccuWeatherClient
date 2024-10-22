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
public struct City: Codable {
    public let version: Int
    public let key: String
    public let type: String
    public let rank: Int
    public let localizedName, englishName: String
    public let primaryPostalCode: String
    public let region, country: Country
    public let administrativeArea: AdministrativeArea
    public let timeZone: TimeZone
    public let geoPosition: GeoPosition
    public let isAlias: Bool
    public let supplementalAdminAreas: [SupplementalAdminArea]
    public let dataSets: [String]
    public let details: Details?

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
        case details = "Details"
    }

    public init(version: Int, key: String, type: String, rank: Int, localizedName: String, englishName: String, primaryPostalCode: String, region: Country, country: Country, administrativeArea: AdministrativeArea, timeZone: TimeZone, geoPosition: GeoPosition, isAlias: Bool, supplementalAdminAreas: [SupplementalAdminArea], dataSets: [String], details: Details?) {
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
        self.details = details
    }
}

// MARK: - Details
public struct Details: Codable {
    public let key, stationCode: String
    public let stationGmtOffset: Double?
    public let bandMap, climo, localRadar: String
    public let mediaRegion: String?
    public let metar, nxMetro, nxState: String
    public let population: Int?
    public let primaryWarningCountyCode, primaryWarningZoneCode, satellite, synoptic: String
    public let marineStation: String
    public let marineStationGmtOffset: Double?
    public let videoCode, locationStem: String
    public let dma: DMA?
    public let partnerId: Int?
    public let sources: [SourceElement]
    public let canonicalPostalCode, canonicalLocationKey: String

    enum CodingKeys: String, CodingKey {
        case key = "Key"
        case stationCode = "StationCode"
        case stationGmtOffset = "StationGmtOffset"
        case bandMap = "BandMap"
        case climo = "Climo"
        case localRadar = "LocalRadar"
        case mediaRegion = "MediaRegion"
        case metar = "Metar"
        case nxMetro = "NXMetro"
        case nxState = "NXState"
        case population = "Population"
        case primaryWarningCountyCode = "PrimaryWarningCountyCode"
        case primaryWarningZoneCode = "PrimaryWarningZoneCode"
        case satellite = "Satellite"
        case synoptic = "Synoptic"
        case marineStation = "MarineStation"
        case marineStationGmtOffset = "MarineStationGMTOffset"
        case videoCode = "VideoCode"
        case locationStem = "LocationStem"
        case dma = "DMA"
        case partnerId = "PartnerID"
        case sources = "Sources"
        case canonicalPostalCode = "CanonicalPostalCode"
        case canonicalLocationKey = "CanonicalLocationKey"
    }

    public init(key: String, stationCode: String, stationGmtOffset: Double, bandMap: String, climo: String, localRadar: String, mediaRegion: String?, metar: String, nxMetro: String, nxState: String, population: Int?, primaryWarningCountyCode: String, primaryWarningZoneCode: String, satellite: String, synoptic: String, marineStation: String, marineStationGmtOffset: Double?, videoCode: String, locationStem: String, dma: DMA?, partnerId: Int?, sources: [SourceElement], canonicalPostalCode: String, canonicalLocationKey: String) {
        self.key = key
        self.stationCode = stationCode
        self.stationGmtOffset = stationGmtOffset
        self.bandMap = bandMap
        self.climo = climo
        self.localRadar = localRadar
        self.mediaRegion = mediaRegion
        self.metar = metar
        self.nxMetro = nxMetro
        self.nxState = nxState
        self.population = population
        self.primaryWarningCountyCode = primaryWarningCountyCode
        self.primaryWarningZoneCode = primaryWarningZoneCode
        self.satellite = satellite
        self.synoptic = synoptic
        self.marineStation = marineStation
        self.marineStationGmtOffset = marineStationGmtOffset
        self.videoCode = videoCode
        self.locationStem = locationStem
        self.dma = dma
        self.partnerId = partnerId
        self.sources = sources
        self.canonicalPostalCode = canonicalPostalCode
        self.canonicalLocationKey = canonicalLocationKey
    }
}
