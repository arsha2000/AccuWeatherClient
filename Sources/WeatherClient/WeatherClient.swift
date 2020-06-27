import Alamofire
import Foundation
import Combine

final class WeatherClient {
    
    private var apiKey: String?
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    public func authenticate(with key: String) {
        self.apiKey = key
    }
    
    public func cityLookup(name: String, completionHandler: @escaping (Result<[City], Error>) -> ()) {
        guard let key = apiKey else {
            completionHandler(.failure(WeatherAPIError.notAuthenticated))
            return
        }
        
        let endpoint = WeatherEndpoint.cityLookup(apiKey: key, name: name)
        AF.request(endpoint)
            .validate()
            .responseDecodable(of: [City].self, decoder: jsonDecoder) { (response) in
                switch response.result {
                case let .failure(error as Error): completionHandler(.failure(error))
                case let .success(cities): completionHandler(.success(cities))
                }
            }
    }
    
    public func cityCurrentWeather(cityKey: String, completionHandler: @escaping (Result<WeatherEntry, Error>) -> ()) {
        guard let key = apiKey else {
            completionHandler(.failure(WeatherAPIError.notAuthenticated))
            return
        }
        
        let endpoint = WeatherEndpoint.cityCurrentWeather(apiKey: key, cityKey: cityKey)
        AF.request(endpoint)
            .validate()
            .responseDecodable(of: [WeatherEntry].self, decoder: jsonDecoder) { (response) in
                switch response.result {
                case let .failure(error as Error): completionHandler(.failure(error))
                case let .success(entries):
                    if entries.isEmpty {
                        completionHandler(.failure(WeatherAPIError.invalidResponse))
                        return
                    }
                    completionHandler(.success(entries[0]))
                }
            }
    }
    
}

@available(iOS 13, *)
extension WeatherClient {
    public func cityLookup(name: String) -> AnyPublisher<[City], Error> {
        guard let key = apiKey else {
            return Fail(error: WeatherAPIError.notAuthenticated)
                .eraseToAnyPublisher()
        }
        
        let endpoint = WeatherEndpoint.cityLookup(apiKey: key, name: name)
        return AF.request(endpoint)
            .validate()
            .publishDecodable(type: [City].self, decoder: jsonDecoder)
            .value()
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
    
    public func cityCurrentWeather(cityKey: String) -> AnyPublisher<WeatherEntry, Error> {
        guard let key = apiKey else {
            return Fail(error: WeatherAPIError.notAuthenticated)
                .eraseToAnyPublisher()
        }
        
        let endpoint = WeatherEndpoint.cityCurrentWeather(apiKey: key, cityKey: cityKey)
        return AF.request(endpoint)
            .validate()
            .publishDecodable(type: [WeatherEntry].self, decoder: self.jsonDecoder)
            .result()
            .tryMap { (result) -> WeatherEntry in
                switch result {
                case let .failure(error as Error):
                    throw error
                case let .success(entries):
                    if entries.isEmpty {
                        throw WeatherAPIError.invalidResponse
                    }
                    return entries[0]
                }
            }
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}











