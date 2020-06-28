//
//  Elevation.swift
//  WeatherClient
//
//  Created by Arsha Hassas on 6/27/20.
//

import Foundation

// MARK: - Elevation
public struct Elevation: Codable, Hashable {
    public let metric: WeatherUnit
    public let imperial: WeatherUnit

    enum CodingKeys: String, CodingKey {
        case metric = "Metric"
        case imperial = "Imperial"
    }

    public init(metric: WeatherUnit, imperial: WeatherUnit) {
        self.metric = metric
        self.imperial = imperial
    }
}
