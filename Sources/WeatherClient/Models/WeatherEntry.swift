//
//  WeatherEntry.swift
//  WeatherClient
//
//  Created by Arsha Hassas on 6/27/20.
//

import Foundation

// MARK: - WeatherEntry
public struct WeatherEntry: Codable {
    public let localObservationDateTime: Date
    public let epochTime: Int
    public let weatherText: String
    public let weatherIcon: Int?
    public let hasPrecipitation: Bool
    public let precipitationType: String?
    public let isDayTime: Bool
    public let temperature: Temperature
    public let mobileLink, link: String

    enum CodingKeys: String, CodingKey {
        case localObservationDateTime = "LocalObservationDateTime"
        case epochTime = "EpochTime"
        case weatherText = "WeatherText"
        case weatherIcon = "WeatherIcon"
        case hasPrecipitation = "HasPrecipitation"
        case precipitationType = "PrecipitationType"
        case isDayTime = "IsDayTime"
        case temperature = "Temperature"
        case mobileLink = "MobileLink"
        case link = "Link"
    }

    public init(localObservationDateTime: Date, epochTime: Int, weatherText: String, weatherIcon: Int, hasPrecipitation: Bool, precipitationType: String?, isDayTime: Bool, temperature: Temperature, mobileLink: String, link: String) {
        self.localObservationDateTime = localObservationDateTime
        self.epochTime = epochTime
        self.weatherText = weatherText
        self.weatherIcon = weatherIcon
        self.hasPrecipitation = hasPrecipitation
        self.precipitationType = precipitationType
        self.isDayTime = isDayTime
        self.temperature = temperature
        self.mobileLink = mobileLink
        self.link = link
    }
}
