//
//  GeoPosition.swift
//  WeatherClient
//
//  Created by Arsha Hassas on 6/27/20.
//

import Foundation

// MARK: - GeoPosition
public struct GeoPosition: Codable, Hashable {
    public let latitude: Double
    public let longitude: Double
    public let elevation: Elevation

    enum CodingKeys: String, CodingKey {
        case latitude = "Latitude"
        case longitude = "Longitude"
        case elevation = "Elevation"
    }

    public init(latitude: Double, longitude: Double, elevation: Elevation) {
        self.latitude = latitude
        self.longitude = longitude
        self.elevation = elevation
    }
}
