//
//  WeatherAPIError.swift
//  WeatherClient
//
//  Created by Arsha Hassas on 6/25/20.
//

import Foundation

public enum WeatherAPIError: Error {
    case invalidURL, notAuthenticated, invalidResponse
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Provided url endpoint is invalid".localizedCapitalized
        case .notAuthenticated:
            return "WeatherClient is not authenticated".localizedCapitalized
        case .invalidResponse:
            return "An invalid response was received from the server".localizedCapitalized
        }
    }
}
