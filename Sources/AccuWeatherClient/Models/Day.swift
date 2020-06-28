//
//  Day.swift
//  AccruWeatherClient
//
//  Created by Arsha Hassas on 6/28/20.
//

import Foundation

// MARK: - Day
public struct Day: Codable {
    public let icon: Int
    public let iconPhrase: String
    public let hasPrecipitation: Bool
    public let precipitationType, precipitationIntensity: String?

    enum CodingKeys: String, CodingKey {
        case icon = "Icon"
        case iconPhrase = "IconPhrase"
        case hasPrecipitation = "HasPrecipitation"
        case precipitationType = "PrecipitationType"
        case precipitationIntensity = "PrecipitationIntensity"
    }

    public init(icon: Int, iconPhrase: String, hasPrecipitation: Bool, precipitationType: String?, precipitationIntensity: String?) {
        self.icon = icon
        self.iconPhrase = iconPhrase
        self.hasPrecipitation = hasPrecipitation
        self.precipitationType = precipitationType
        self.precipitationIntensity = precipitationIntensity
    }
}
