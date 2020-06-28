//
//  Temperature.swift
//  WeatherClient
//
//  Created by Arsha Hassas on 6/27/20.
//

import Foundation

// MARK: - Temperature
public struct Temperature: Codable {
    public let metric, imperial: WeatherUnit

    enum CodingKeys: String, CodingKey {
        case metric = "Metric"
        case imperial = "Imperial"
    }

    public init(metric: WeatherUnit, imperial: WeatherUnit) {
        self.metric = metric
        self.imperial = imperial
    }
}
