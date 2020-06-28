//
//  DailyForecaseResponse.swift
//  AccruWeatherClient
//
//  Created by Arsha Hassas on 6/28/20.
//

import Foundation

// MARK: - DailyForecastResponse
public struct DailyForecastResponse: Codable {
    public let headline: Headline
    public let dailyForecasts: [DailyForecast]

    enum CodingKeys: String, CodingKey {
        case headline = "Headline"
        case dailyForecasts = "DailyForecasts"
    }

    public init(headline: Headline, dailyForecasts: [DailyForecast]) {
        self.headline = headline
        self.dailyForecasts = dailyForecasts
    }
}
