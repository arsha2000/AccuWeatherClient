//
//  ContentView.swift
//  AccuWeatherTest
//
//  Created by Arsha Hassas on 6/29/20.
//

import SwiftUI
import AccuWeatherClient
import Combine

struct ContentView: View {
    
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        Group {
            if let entry = viewModel.entry, let city = viewModel.city {
                ZStack(alignment: .top) {
                    RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                        .fill(Color.white)
                        .shadow(radius: 1, y: 2)
                    
                    VStack {
                        HStack {
                            VStack {
                                Text(city.englishName)
                                    .font(.title)
                                    .foregroundColor(.primary)
                                
                                Text(viewModel.relativeString(for: entry.localObservationDateTime))
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                        }
                        .padding(.vertical)
                        
                        Text(entry.weatherText)
                    }
                }
                .padding()
            } else {
                Text("Fetching...")
            }
        }
        .onAppear(perform: viewModel.fetch)
    }
}

extension ContentView {
    final class ViewModel: ObservableObject {
        
        @Published var entry: WeatherEntry? = nil
        @Published var city: City? = nil
        
        private let client = WeatherClient()
        private var cancellables = Set<AnyCancellable>()
        
        func fetch() {
            client.authenticate(with: "pYn2mKdUEy0qnl1MmxFn6irm9OqPaQxI")
            
            client.cityLookup(name: "New York", withDetails: false)
                .compactMap({ (cities) -> String? in
                    if let city = cities.first {
                        self.city = city
                        return city.key
                    } else {
                        return nil
                    }
                })
                .flatMap { (key) in
                    return self.client.cityCurrentWeather(cityKey: key)
                }
                .sink { (error) in
                    print(error)
                } receiveValue: { (entry) in
                    self.entry = entry
                }
                .store(in: &cancellables)
        }
        
        private let formatter = RelativeDateTimeFormatter()
        func relativeString(for date: Date) -> String {
            return formatter.localizedString(for: date, relativeTo: Date())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
