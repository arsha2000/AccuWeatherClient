//
//  CityListView.swift
//  AccuWeatherTest
//
//  Created by Arsha Hassas on 7/9/20.
//

import SwiftUI
import Combine
import UIKit
import AccuWeatherClient

struct CityListView: View {
    
    @ObservedObject var viewModel: ViewModel
    
    @State private var selectedCity: City? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $viewModel.searchText)
                .padding(.horizontal, 5)
            List {
                ForEach(viewModel.cities, id: \.key) { city in
                    Button(action: {
                        self.selectedCity = city
                    }, label: {
                        Text(verbatim: "\(city.englishName), \(city.administrativeArea.englishName), \(city.country.englishName)")
                    })
                    
                }
            }
            .listStyle(PlainListStyle())
            .animation(nil)
            .padding(.bottom, viewModel.keyboardSize.height)
            .animation(.default)
            }
            .navigationTitle("Cities")
            .sheet(item: $selectedCity) { (city) in
                CityWeatherView(viewModel: .init(weatherClient: viewModel.weatherClient, city: city))
            }
        }
    }
}
extension CityListView {
    final class ViewModel: ObservableObject {
        
        @Published var searchText = ""
        @Published var cities = [City]()
        @Published var keyboardSize = CGSize.zero

        let weatherClient: WeatherClient
                
        init(weatherClient: WeatherClient) {
            self.weatherClient = weatherClient
                    
            observeSearchText()
            observeKeyboard()
        }
        
        private func observeSearchText() {
            $searchText
                .removeDuplicates()
                .debounce(for: .milliseconds(250), scheduler: DispatchQueue.main)
                .flatMap { (text) -> AnyPublisher<[City], Never> in
                    if !text.isEmpty {
                        return self.weatherClient.cityLookup(name: text, withDetails: false)
                            .replaceError(with: [])
                            .eraseToAnyPublisher()
                    }
                    else {
                        return Just([])
                            .eraseToAnyPublisher()
                    }
                }
                .receive(on: DispatchQueue.main)
                .assign(to: $cities)
        }
        
        private func observeKeyboard() {
            
            let keyboardWillShowPublisher = NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillShowNotification)
            
            let keyboardWillChangePublisher = NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillChangeFrameNotification)
            
            let keyboardWillHidePublisher = NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillHideNotification)
            
            keyboardWillShowPublisher
                .merge(with: keyboardWillChangePublisher, keyboardWillHidePublisher)
                .map { notification in
                    
                    if notification.name == UIResponder.keyboardWillHideNotification {
                        return .zero
                    }
                    
                    if let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                        let size = value.cgRectValue.size
                        return size
                    }
                    
                    return .zero
                }
                .assign(to: $keyboardSize)
        }
    }
    
}

extension City: Identifiable {
    public var id: String {
        return self.key
    }
}
