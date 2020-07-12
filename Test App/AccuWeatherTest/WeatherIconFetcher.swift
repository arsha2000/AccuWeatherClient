//
//  WeatherIconFetcher.swift
//  AccuWeatherTest
//
//  Created by Arsha Hassas on 7/11/20.
//

import Foundation
import UIKit

final class WeatherIconFetcher {
    private init() {}
    typealias IconNumber = Int
    
    static func systemIcon(for iconNumber: IconNumber) -> String {
        switch iconNumber {
        case 1...4: return "sun.max.fill"
        case 5...11: return "cloud.fill"
        case 12...18: return "cloud.heavyrain.fill"
        case 19...29: return "cloud.snow.fill"
        default: return "smoke.fill"
        }
    }
    
    static func color(for iconNumber: IconNumber) -> UIColor {
        switch iconNumber {
        case 1...4: return UIColor.systemYellow
        default: return UIColor.systemGray3
        }
    }
}
