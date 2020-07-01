//
//  DataSetElement.swift
//  AccuWeatherClient
//
//  Created by Arsha Hassas on 7/1/20.
//

import Foundation

public enum DataSetElement: String, Codable {
    case airQualityCurrentConditions = "AirQualityCurrentConditions"
    case airQualityForecasts = "AirQualityForecasts"
    case alerts = "Alerts"
    case currentConditions = "CurrentConditions"
    case dailyAirQualityForecast = "DailyAirQualityForecast"
    case dailyForecast = "DailyForecast"
    case dailyPollenForecast = "DailyPollenForecast"
    case dangerousThunderstormAlertPushNotifications = "Dangerous Thunderstorm Alert Push Notifications"
    case forecastConfidence = "ForecastConfidence"
    case futureRadar = "FutureRadar"
    case hourlyForecast = "HourlyForecast"
    case minuteCast = "MinuteCast"
    case radar = "Radar"
    case severeWeatherPushNotifications = "Severe Weather Push Notifications"
}
