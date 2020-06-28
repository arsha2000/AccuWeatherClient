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

    static var allTests = [
        ("testCityLookup", testCityLookup),
        ("testCityCurrentWeather", testCityCurrentWeather),
    ]
}
