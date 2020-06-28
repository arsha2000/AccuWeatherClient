//
//  DailyForecast.swift
//  AccruWeatherClient
//
//  Created by Arsha Hassas on 6/28/20.
//

import Foundation

// MARK: - DailyForecast
public struct DailyForecast: Codable {
    public let date: Date
    public let epochDate: Int
    public let temperature: ForecastTemperature
    public let day, night: Day
    public let sources: [String]
    public let mobileLink, link: String

    enum CodingKeys: String, CodingKey {
        case date = "Date"
        case epochDate = "EpochDate"
        case temperature = "Temperature"
        case day = "Day"
        case night = "Night"
        case sources = "Sources"
        case mobileLink = "MobileLink"
        case link = "Link"
    }

    public init(date: Date, epochDate: Int, temperature: ForecastTemperature, day: Day, night: Day, sources: [String], mobileLink: String, link: String) {
        self.date = date
        self.epochDate = epochDate
        self.temperature = temperature
        self.day = day
        self.night = night
        self.sources = sources
        self.mobileLink = mobileLink
        self.link = link
    }
}
