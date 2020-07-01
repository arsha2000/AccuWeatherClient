//
//  WeatherEndpoint.swift
//  WeatherClient
//
//  Created by Arsha Hassas on 6/25/20.
//

import Foundation
import Alamofire

enum WeatherEndpoint: Endpoint {
    
    case cityLookup(apiKey: String, name: String, includeDetails: Bool = false)
    case cityCurrentWeather(apiKey: String, cityKey: String)
    case cityDailyForecast(apiKey: String, cityKey: String, frequency: DailyFrequency)
    
    private var baseURL: URL {
        guard let url = URL(string: "http://dataservice.accuweather.com") else {
            fatalError("Weather Client base URL is invalid")
            
        }
        
        return url
    }
    
    var url: URL {
        switch self {
        case .cityLookup:
            return baseURL.appendingPathComponent("locations/v1/cities/search")
        case let .cityCurrentWeather(_, cityKey):
            return baseURL.appendingPathComponent("currentconditions/v1/\(cityKey)")
        case let .cityDailyForecast(_, cityKey, frequency):
            var url = baseURL.appendingPathComponent("forecasts/v1/daily")
            switch frequency {
            case .oneDay: url.appendPathComponent("1day")
            case .fiveDays: url.appendPathComponent("5day")
            case .tenDays: url.appendPathComponent("10day")
            case .fifteenDays: url.appendPathComponent("15day")
            }
            return url.appendingPathComponent(cityKey)
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .cityLookup, .cityCurrentWeather, .cityDailyForecast: return .get
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .cityLookup, .cityCurrentWeather, .cityDailyForecast:
            return [
            .accept("application/json")
        ]
        }
    }
    
    var parameters: [String:String] {
        switch self {
        case let .cityLookup(apiKey, name, includeDetails):
            return [
                "apikey": apiKey,
                "q": name,
                "details": includeDetails ? "true" : "false"
            ]
        case let .cityCurrentWeather(apiKey, _):
            return [
                "apikey": apiKey
            ]
        case let .cityDailyForecast(apiKey, _, _):
            return [
                "apikey": apiKey
            ]
        }
    }
}
