//
//  CityWeatherView.swift
//  AccuWeatherTest
//
//  Created by Arsha Hassas on 7/9/20.
//

import SwiftUI
import Combine
import AccuWeatherClient

struct CityWeatherView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var viewModel: ViewModel
    
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                LazyVStack {
                    if let entry = viewModel.weatherEntry {
                        WeatherEntryCell(entry: entry, imageSystemName: "sun.max.fill")
                        
                        Divider()
                        
                        ForEach(viewModel.forecastEntries, id: \.date) { forecast in
                            ForecastCell(forecast: forecast)
                        }
                        
                        Spacer()
                    } else {
                        ProgressView("Loading...")
                    }
                }
            }
            .navigationBarTitle(viewModel.city.englishName, displayMode: .large)
            .navigationBarItems(trailing: Button("Done", action: { self.presentationMode.wrappedValue.dismiss() }))
            .alert(item: $viewModel.error) { (error) -> Alert in
                Alert(title: Text("An error occurred"),
                      message: Text(error.localizedDescription),
                      dismissButton: .default(Text("Ok")))
            }
        }
    }
}

extension CityWeatherView {
    final class ViewModel: ObservableObject {
        
        let weatherClient: WeatherClient
        let city: City
        
        @Published var weatherEntry: WeatherEntry? = nil
        @Published var forecastEntries: [DailyForecast] = []
        @Published var error: NSError?
        
        private var cancellables = Set<AnyCancellable>()
        
        init(weatherClient: WeatherClient, city: City) {
            self.weatherClient = weatherClient
            self.city = city
            
            fetchWeather()
        }
        
        private func fetchWeather() {
            weatherClient
                .cityCurrentWeather(cityKey: city.key)
                .zip(weatherClient.cityDailyForecast(cityKey: city.key, frequency: .fiveDays, useMetric: true))
                .sink { (completion) in
                    switch completion {
                    case let .failure(error as NSError):
                        self.error = error
                    case .finished:
                        break
                    }
                } receiveValue: { (weatherEntry, dailForecastResponse) in
                    self.weatherEntry = weatherEntry
                    self.forecastEntries = dailForecastResponse.dailyForecasts
                }
                .store(in: &cancellables)
        }
        
    }
}

extension NSError: Identifiable {
    public var id: Int {
        return self.code
    }
}



