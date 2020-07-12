//
//  AccuWeatherTestApp.swift
//  AccuWeatherTest
//
//  Created by Arsha Hassas on 6/29/20.
//

import SwiftUI
import AccuWeatherClient

@main
struct AccuWeatherTestApp: App {
    
    var body: some Scene {
        
        let weatherClient = WeatherClient()
        let authKey = "pYn2mKdUEy0qnl1MmxFn6irm9OqPaQxI"
        if authKey.isEmpty {
            fatalError("Authentication key is not set")
        }
        weatherClient.authenticate(with: authKey)
        
        return WindowGroup {
            CityListView(viewModel: .init(weatherClient: weatherClient))
        }
    }
}
