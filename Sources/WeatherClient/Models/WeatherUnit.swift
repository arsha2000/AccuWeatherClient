//
//  WeatherUnit.swift
//  WeatherClient
//
//  Created by Arsha Hassas on 6/27/20.
//

import Foundation

// MARK: - WeatherUnit
public struct WeatherUnit: Codable, Hashable {
    public let value: Double?
    public let unit: String
    public let unitType: Int

    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case unit = "Unit"
        case unitType = "UnitType"
    }

    public init(value: Double, unit: String, unitType: Int) {
        self.value = value
        self.unit = unit
        self.unitType = unitType
    }
}
