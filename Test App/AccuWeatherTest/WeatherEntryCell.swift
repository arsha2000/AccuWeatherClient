//
//  WeatherEntryCell.swift
//  AccuWeatherTest
//
//  Created by Arsha Hassas on 7/11/20.
//

import SwiftUI
import AccuWeatherClient

struct WeatherEntryCell: View {
    
    let entry: WeatherEntry
    let imageSystemName: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Today")
                    .font(.title2)
                    .foregroundColor(.primary)
                Text(entry.weatherText)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            if let temp = entry.temperature.metric.value {
                Text(String(format: "%.1f ℃", temp))
                    .foregroundColor(.secondary)
                    .padding()
            }
            if let weatherIcon = entry.weatherIcon {
                Image(systemName: WeatherIconFetcher.systemIcon(for: weatherIcon))
                    .resizable()
                    .imageScale(.large)
                    .frame(width: 40, height: 40)
                    .foregroundColor(Color(WeatherIconFetcher.color(for: weatherIcon)))
                    .scaledToFit()
                    .padding(.vertical)
            }
        }
        .padding()
    }
}
