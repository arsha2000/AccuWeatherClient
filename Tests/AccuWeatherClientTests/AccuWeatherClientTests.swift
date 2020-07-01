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
        client.cityLookup(name: "London") { (result) in
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
        XCTAssertEqual(city?.key, "328328")
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

struct TopLevel: Codable {
    let version: Int
    let key, type: String
    let rank: Int
    let localizedName, englishName, primaryPostalCode: String
    let region, country: Country
    let administrativeArea: AdministrativeArea
    let timeZone: TimeZone
    let geoPosition: GeoPosition
    let isAlias: Bool
    let supplementalAdminAreas: [SupplementalAdminArea]
    let dataSets: [String]

    enum CodingKeys: String, CodingKey {
        case version = "Version"
        case key = "Key"
        case type = "Type"
        case rank = "Rank"
        case localizedName = "LocalizedName"
        case englishName = "EnglishName"
        case primaryPostalCode = "PrimaryPostalCode"
        case region = "Region"
        case country = "Country"
        case administrativeArea = "AdministrativeArea"
        case timeZone = "TimeZone"
        case geoPosition = "GeoPosition"
        case isAlias = "IsAlias"
        case supplementalAdminAreas = "SupplementalAdminAreas"
        case dataSets = "DataSets"
    }
}

struct AdministrativeArea: Codable {
    let id, localizedName, englishName: String
    let level: Int
    let localizedType, englishType, countryID: String

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case localizedName = "LocalizedName"
        case englishName = "EnglishName"
        case level = "Level"
        case localizedType = "LocalizedType"
        case englishType = "EnglishType"
        case countryID = "CountryID"
    }
}

struct Country: Codable {
    let id, localizedName, englishName: String

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case localizedName = "LocalizedName"
        case englishName = "EnglishName"
    }
}

struct GeoPosition: Codable {
    let latitude, longitude: Double
    let elevation: Elevation

    enum CodingKeys: String, CodingKey {
        case latitude = "Latitude"
        case longitude = "Longitude"
        case elevation = "Elevation"
    }
}

struct Elevation: Codable {
    let metric, imperial: Imperial

    enum CodingKeys: String, CodingKey {
        case metric = "Metric"
        case imperial = "Imperial"
    }
}

struct Imperial: Codable {
    let value: Int
    let unit: String
    let unitType: Int

    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case unit = "Unit"
        case unitType = "UnitType"
    }
}

struct SupplementalAdminArea: Codable {
    let level: Int
    let localizedName, englishName: String

    enum CodingKeys: String, CodingKey {
        case level = "Level"
        case localizedName = "LocalizedName"
        case englishName = "EnglishName"
    }
}

struct TimeZone: Codable {
    let code, name: String
    let gmtOffset: Int
    let isDaylightSaving: Bool
    let nextOffsetChange: String

    enum CodingKeys: String, CodingKey {
        case code = "Code"
        case name = "Name"
        case gmtOffset = "GmtOffset"
        case isDaylightSaving = "IsDaylightSaving"
        case nextOffsetChange = "NextOffsetChange"
    }
}

// MARK: Convenience initializers

extension TopLevel {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(TopLevel.self, from: data) else { return nil }
        self = me
    }

    init?(_ json: String, using encoding: String.Encoding = .utf8) {
        guard let data = json.data(using: encoding) else { return nil }
        self.init(data: data)
    }

    init?(fromURL url: String) {
        guard let url = URL(string: url) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        self.init(data: data)
    }

    var jsonData: Data? {
        return try? JSONEncoder().encode(self)
    }

    var json: String? {
        guard let data = self.jsonData else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

extension AdministrativeArea {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(AdministrativeArea.self, from: data) else { return nil }
        self = me
    }

    init?(_ json: String, using encoding: String.Encoding = .utf8) {
        guard let data = json.data(using: encoding) else { return nil }
        self.init(data: data)
    }

    init?(fromURL url: String) {
        guard let url = URL(string: url) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        self.init(data: data)
    }

    var jsonData: Data? {
        return try? JSONEncoder().encode(self)
    }

    var json: String? {
        guard let data = self.jsonData else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

extension Country {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(Country.self, from: data) else { return nil }
        self = me
    }

    init?(_ json: String, using encoding: String.Encoding = .utf8) {
        guard let data = json.data(using: encoding) else { return nil }
        self.init(data: data)
    }

    init?(fromURL url: String) {
        guard let url = URL(string: url) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        self.init(data: data)
    }

    var jsonData: Data? {
        return try? JSONEncoder().encode(self)
    }

    var json: String? {
        guard let data = self.jsonData else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

extension GeoPosition {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(GeoPosition.self, from: data) else { return nil }
        self = me
    }

    init?(_ json: String, using encoding: String.Encoding = .utf8) {
        guard let data = json.data(using: encoding) else { return nil }
        self.init(data: data)
    }

    init?(fromURL url: String) {
        guard let url = URL(string: url) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        self.init(data: data)
    }

    var jsonData: Data? {
        return try? JSONEncoder().encode(self)
    }

    var json: String? {
        guard let data = self.jsonData else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

extension Elevation {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(Elevation.self, from: data) else { return nil }
        self = me
    }

    init?(_ json: String, using encoding: String.Encoding = .utf8) {
        guard let data = json.data(using: encoding) else { return nil }
        self.init(data: data)
    }

    init?(fromURL url: String) {
        guard let url = URL(string: url) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        self.init(data: data)
    }

    var jsonData: Data? {
        return try? JSONEncoder().encode(self)
    }

    var json: String? {
        guard let data = self.jsonData else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

extension Imperial {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(Imperial.self, from: data) else { return nil }
        self = me
    }

    init?(_ json: String, using encoding: String.Encoding = .utf8) {
        guard let data = json.data(using: encoding) else { return nil }
        self.init(data: data)
    }

    init?(fromURL url: String) {
        guard let url = URL(string: url) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        self.init(data: data)
    }

    var jsonData: Data? {
        return try? JSONEncoder().encode(self)
    }

    var json: String? {
        guard let data = self.jsonData else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

extension SupplementalAdminArea {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(SupplementalAdminArea.self, from: data) else { return nil }
        self = me
    }

    init?(_ json: String, using encoding: String.Encoding = .utf8) {
        guard let data = json.data(using: encoding) else { return nil }
        self.init(data: data)
    }

    init?(fromURL url: String) {
        guard let url = URL(string: url) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        self.init(data: data)
    }

    var jsonData: Data? {
        return try? JSONEncoder().encode(self)
    }

    var json: String? {
        guard let data = self.jsonData else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

extension TimeZone {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(TimeZone.self, from: data) else { return nil }
        self = me
    }

    init?(_ json: String, using encoding: String.Encoding = .utf8) {
        guard let data = json.data(using: encoding) else { return nil }
        self.init(data: data)
    }

    init?(fromURL url: String) {
        guard let url = URL(string: url) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        self.init(data: data)
    }

    var jsonData: Data? {
        return try? JSONEncoder().encode(self)
    }

    var json: String? {
        guard let data = self.jsonData else { return nil }
        return String(data: data, encoding: .utf8)
    }
}
