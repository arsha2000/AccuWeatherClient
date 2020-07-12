//
//  ForecastCell.swift
//  AccuWeatherTest
//
//  Created by Arsha Hassas on 7/11/20.
//

import SwiftUI
import AccuWeatherClient

struct ForecastCell: View {
    
    let forecast: DailyForecast
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(relativeString(from: forecast.date))
                    .font(.title2)
                    .foregroundColor(.primary)
                Text(forecast.day.iconPhrase)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Min:")
                        .font(.subheadline)
                        .foregroundColor(.primary)
                    Text("\(string(from: forecast.temperature.minimum.value)) ℃")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                HStack {
                    Text("Max:")
                        .font(.subheadline)
                        .foregroundColor(.primary)
                    Text("\(string(from: forecast.temperature.maximum.value)) ℃")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
            }
            .padding()
            
            Image(systemName: WeatherIconFetcher.systemIcon(for: forecast.day.icon))
                .resizable()
                .imageScale(.medium)
                .frame(width: 40, height: 40)
                .foregroundColor(Color(WeatherIconFetcher.color(for: forecast.day.icon)))
                .scaledToFit()
                .padding(.vertical)
            
        }
        .padding()
    }
    
    private func relativeString(from date: Date) -> String {
        let formatter = RelativeDateTimeFormatter()
        let now = Date()
        return formatter.localizedString(for: date, relativeTo: now).capitalized
    }
    
    private func string(from temp: Double?) -> String {
        if let temp = temp {
            return String(format: "%.0f", temp)
        } else {
            return "N/A"
        }
    }
}
