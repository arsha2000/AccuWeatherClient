import Alamofire
import Foundation
import Combine

public final class WeatherClient {
    
    private var apiKey: String?
    
    public init() {}
    
    public func authenticate(with key: String) {
        self.apiKey = key
    }
    
    public func cityLookup(name: String, completionHandler: @escaping (Result<[City], Error>) -> ()) {
        guard let key = apiKey else {
            completionHandler(.failure(WeatherAPIError.notAuthenticated))
            return
        }
        
        let endpoint = WeatherEndpoint.cityLookup(apiKey: key, name: name)
        request(endpoint, completionHandler: completionHandler)
    }
    
    public func cityCurrentWeather(cityKey: String, completionHandler: @escaping (Result<WeatherEntry, Error>) -> ()) {
        guard let key = apiKey else {
            completionHandler(.failure(WeatherAPIError.notAuthenticated))
            return
        }
        
        
        let endpoint = WeatherEndpoint.cityCurrentWeather(apiKey: key, cityKey: cityKey)
        request(endpoint) { (result: Result<[WeatherEntry], Error>) in
            switch result {
            case let .failure(error): completionHandler(.failure(error))
            case let .success(entries):
                if entries.isEmpty {
                    completionHandler(.failure(WeatherAPIError.invalidResponse))
                    return
                }
                completionHandler(.success(entries[0]))
            }
        }
    }
    
    public func cityDailyForecast(cityKey: String, frequency: DailyFrequency, completionHandler: @escaping (Result<DailyForecastResponse, Error>) -> ()) {
        guard let key = apiKey else {
            completionHandler(.failure(WeatherAPIError.notAuthenticated))
            return
        }
        
        let endpoint = WeatherEndpoint.cityDailyForecast(apiKey: key, cityKey: cityKey, frequency: frequency)
        request(endpoint, completionHandler: completionHandler)
    }
    
    private func request<ReturnType: Decodable>(_ endpoint: Endpoint, completionHandler: @escaping (Result<ReturnType, Error>) -> ()) {
        
        AF.request(endpoint)
            .validate()
            .responseDecodable(of: ReturnType.self, decoder: jsonDecoder()) { (response) in
                switch response.result {
                case let .failure(error as Error): completionHandler(.failure(error))
                case let .success(decodable): completionHandler(.success(decodable))
                }
            }
    }
    
    private func jsonDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
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
        return request(endpoint, type: [City].self)
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
        return request(endpoint, type: [WeatherEntry].self)
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
    
    public func cityDailyForecast(cityKey: String, frequency: DailyFrequency) -> AnyPublisher<DailyForecastResponse, Error> {
        guard let key = apiKey else {
            return Fail(error: WeatherAPIError.notAuthenticated)
                .eraseToAnyPublisher()
        }
        
        let endpoint = WeatherEndpoint.cityDailyForecast(apiKey: key, cityKey: cityKey, frequency: frequency)
        return request(endpoint, type: DailyForecastResponse.self)
            .value()
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
    
    private func request<ReturnType: Decodable>(_ endpoint: Endpoint, type: ReturnType.Type) -> DataResponsePublisher<ReturnType> {
        return AF.request(endpoint)
            .validate()
            .publishDecodable(type: ReturnType.self, decoder: jsonDecoder())
    }
}











