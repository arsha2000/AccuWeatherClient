//
//  ForecastTemperature.swift
//  AccruWeatherClient
//
//  Created by Arsha Hassas on 6/28/20.
//

import Foundation

// MARK: - ForecastTemperature
public struct ForecastTemperature: Codable {
    public let minimum, maximum: WeatherUnit

    enum CodingKeys: String, CodingKey {
        case minimum = "Minimum"
        case maximum = "Maximum"
    }

    public init(minimum: WeatherUnit, maximum: WeatherUnit) {
        self.minimum = minimum
        self.maximum = maximum
    }
}
