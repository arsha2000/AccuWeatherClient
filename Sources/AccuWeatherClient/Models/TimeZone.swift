//
//  TimeZone.swift
//  WeatherClient
//
//  Created by Arsha Hassas on 6/27/20.
//

import Foundation

// MARK: - TimeZone
public struct TimeZone: Codable {
    public let code, name: String
    public let gmtOffset: Double
    public let isDaylightSaving: Bool
    public let nextOffsetChange: Date?

    enum CodingKeys: String, CodingKey {
        case code = "Code"
        case name = "Name"
        case gmtOffset = "GmtOffset"
        case isDaylightSaving = "IsDaylightSaving"
        case nextOffsetChange = "NextOffsetChange"
    }

    public init(code: String, name: String, gmtOffset: Double, isDaylightSaving: Bool, nextOffsetChange: Date?) {
        self.code = code
        self.name = name
        self.gmtOffset = gmtOffset
        self.isDaylightSaving = isDaylightSaving
        self.nextOffsetChange = nextOffsetChange
    }
}
