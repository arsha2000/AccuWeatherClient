//
//  Headline.swift
//  AccruWeatherClient
//
//  Created by Arsha Hassas on 6/28/20.
//

import Foundation

// MARK: - Headline
public struct Headline: Codable {
    public let effectiveDate: Date
    public let effectiveEpochDate, severity: Int
    public let text, category: String
    public let endDate: Date?
    public let endEpochDate: Int
    public let mobileLink, link: String

    enum CodingKeys: String, CodingKey {
        case effectiveDate = "EffectiveDate"
        case effectiveEpochDate = "EffectiveEpochDate"
        case severity = "Severity"
        case text = "Text"
        case category = "Category"
        case endDate = "EndDate"
        case endEpochDate = "EndEpochDate"
        case mobileLink = "MobileLink"
        case link = "Link"
    }

    public init(effectiveDate: Date, effectiveEpochDate: Int, severity: Int, text: String, category: String, endDate: Date, endEpochDate: Int, mobileLink: String, link: String) {
        self.effectiveDate = effectiveDate
        self.effectiveEpochDate = effectiveEpochDate
        self.severity = severity
        self.text = text
        self.category = category
        self.endDate = endDate
        self.endEpochDate = endEpochDate
        self.mobileLink = mobileLink
        self.link = link
    }
}
