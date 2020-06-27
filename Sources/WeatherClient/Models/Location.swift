//
//  Location.swift
//  WeatherClient
//
//  Created by Arsha Hassas on 6/25/20.
//

import Foundation

struct Location: Hashable, Codable {
    let name: String
    let country: String
    let region: String
    let longtitude: Double
    let latitude: Double
    let timezoneId: String
    let utcOffset: Double
}
