//
//  WeatherEndpoint.swift
//  WeatherClient
//
//  Created by Arsha Hassas on 6/25/20.
//

import Foundation
import Alamofire

enum WeatherEndpoint: Endpoint {
    
    case cityLookup(apiKey: String, name: String)
    case cityCurrentWeather(apiKey: String, cityKey: String)
    
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
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .cityLookup, .cityCurrentWeather: return .get
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .cityLookup, .cityCurrentWeather: return [
            .accept("application/json")
        ]
        }
    }
    
    var parameters: [String:String] {
        switch self {
        case let .cityLookup(apiKey, name):
            return [
                "apikey": apiKey,
                "q": name
            ]
        case let .cityCurrentWeather(apiKey, _):
            return [
                "apikey": apiKey
            ]
        }
    }
}
