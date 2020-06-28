import XCTest
import Combine
@testable import WeatherClient

final class AccuWeatherClientTests: XCTestCase {
    
    let key = "pYn2mKdUEy0qnl1MmxFn6irm9OqPaQxI"
    let client = WeatherClient()
    
    func testCityLookup() {

        var city: City?
        var error: Error?
        
        let expectation = self.expectation(description: "city-lookup")
        
        client.authenticate(with: key)
        client.cityLookup(name: "denizli") { (result) in
            switch result {
            case let .failure(e):
                print(e.localizedDescription)
                error = e
            case let .success(cities):
                city = cities.first
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
        XCTAssertNotNil(city)
        XCTAssertNil(error)
        XCTAssertEqual(city?.key, "317679")
    }
    
    func testCityCurrentWeather() {

        var entry: WeatherEntry?
        var error: Error?
        
        let expectation = self.expectation(description: "city-current-weather")
        
        client.authenticate(with: key)
        client.cityCurrentWeather(cityKey: "328328") { (result) in
            switch result {
            case let .failure(e):
                print(e.localizedDescription)
                error = e
            case let .success(e):
                entry = e
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
        XCTAssertNotNil(entry)
        XCTAssertNil(error)
    }
    
    public func testAuthentication() {
        var errors = [Error]()
        var expectations = [XCTestExpectation]()
       
        
        // purposefully not authenticating
        
        if #available(iOS 13, *) {
            
            var cancellables = Set<AnyCancellable>()
            
            let e1 = expectation(description: "city-current-weather-publisher-authentication")
            expectations.append(e1)
            client.cityCurrentWeather(cityKey: "328328")
                .sink { (completion) in
                    if case let .failure(error) = completion {
                        errors.append(error)
                    }
                    e1.fulfill()
                } receiveValue: { (_) in
                }
                .store(in: &cancellables)
            
            let e2 = expectation(description: "city-lookup-publisher-authentication")
            expectations.append(e2)
            client.cityLookup(name: "London")
                .sink { (completion) in
                    if case let .failure(error) = completion {
                        errors.append(error)
                    }
                    e2.fulfill()
                } receiveValue: { (_) in
                }
                .store(in: &cancellables)
        }
        
        let e3 = expectation(description: "city-current-authentication")
        expectations.append(e3)
        client.cityCurrentWeather(cityKey: "328328") { (result) in
            if case let .failure(error) = result {
                errors.append(error)
            }
            e3.fulfill()
        }
        
        let e4 = expectation(description: "city-lookup-authentication")
        expectations.append(e4)
        client.cityLookup(name: "London") { (result) in
            if case let .failure(error) = result {
                errors.append(error)
            }
            e4.fulfill()
        }
        
        
        wait(for: expectations, timeout: 5)
        XCTAssertEqual(expectations.count, errors.count)
        XCTAssertTrue(errors.allSatisfy({ (error) -> Bool in
            if let weatherError = error as? WeatherAPIError {
                return weatherError == .notAuthenticated
            }
            return false
        }))
    }
    
    func testCityDailyForecast() {
        var forecastResponse: DailyForecastResponse?
        var error: Error?
        
        let expectation = self.expectation(description: "city-daily-forecast")
        
        client.authenticate(with: key)
        client.cityDailyForecast(cityKey: "328328", frequency: .fiveDays) { (result) in
            switch result {
            case let .failure(e): error = e
            case let .success(response): forecastResponse = response
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
        XCTAssertNotNil(forecastResponse)
        XCTAssertFalse(forecastResponse?.dailyForecasts.isEmpty ?? true)
        XCTAssertNil(error)
    }
    
    @available(iOS 13, *)
    func testCityLookupPublisher() {
        var city: City?
        var error: Error?
        var cancellables = Set<AnyCancellable>()
        
        let expectation = self.expectation(description: "city-lookup-publisher")
        
        client.authenticate(with: key)
        client.cityLookup(name: "denizli")
            .sink { (completion) in
                switch completion {
                case let .failure(e):
                    error = e
                case .finished:
                    break
                }
                expectation.fulfill()
            } receiveValue: { (cities) in
                city = cities.first
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5)
        XCTAssertNotNil(city)
        XCTAssertNil(error)
        XCTAssertEqual(city!.key, "317679")

    }
    
    @available(iOS 13, *)
    func testCityCurrentWeatherPublisher() {
        var entry: WeatherEntry?
        var error: Error?
        var cancellables = Set<AnyCancellable>()
        
        let expectation = self.expectation(description: "city-current-weather-publisher")
        
        client.authenticate(with: key)
        client.cityCurrentWeather(cityKey: "328328")
            .sink { (completion) in
                switch completion {
                case let .failure(e):
                    error = e
                case .finished: break
                }
                expectation.fulfill()
            } receiveValue: { (e) in
                entry = e
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5)
        XCTAssertNotNil(entry)
        XCTAssertNil(error)
    }
    
    @available(iOS 13, *)
    func testCityDailyForecasrPublisher() {
        var forecastResponse: DailyForecastResponse?
        var error: Error?
        var cancellables = Set<AnyCancellable>()
        
        let expectation = self.expectation(description: "city-daily-forecase-publisher")
        
        client.authenticate(with: key)
        client.cityDailyForecast(cityKey: "328328", frequency: .fiveDays)
            .sink { (completion) in
                switch completion {
                case let .failure(e): error = e
                case .finished: break
                }
                expectation.fulfill()
            } receiveValue: { (response) in
                forecastResponse = response
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5)
        XCTAssertNotNil(forecastResponse)
        XCTAssertFalse(forecastResponse?.dailyForecasts.isEmpty ?? true)
        XCTAssertNil(error)
    }

    static var allTests: [(String, (AccuWeatherClientTests) -> () -> ())] {
        var tests = [
            ("testCityLookup", testCityLookup),
            ("testCityCurrentWeather", testCityCurrentWeather),
            ("testCityDailyForecast", testCityDailyForecast),
            ("testAuthentication", testAuthentication)
        ]
        
        if #available(iOS 13, *) {
            tests.append(contentsOf: [
                ("testCityLookupPublisher", testCityLookupPublisher),
                ("testCityCurrentWeatherPublisher", testCityCurrentWeatherPublisher),
                ("testCityDailyForecasrPublisher", testCityDailyForecasrPublisher)
            ])
        }
        
        return tests
    }
}
