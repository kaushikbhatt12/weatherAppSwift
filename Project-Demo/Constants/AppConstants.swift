//
//  AppConstants.swift
//  Project-Demo
//
//  Created by kaushik.bha on 10/09/24.
//

import Foundation

@objc class AppConstants: NSObject {
    static let cityData = [
        CityModel(cityName: "New York", lat: 40.7128, lon: -74.0060),
        CityModel(cityName: "Los Angeles", lat: 34.0522, lon: -118.2437),
        CityModel(cityName: "Chicago", lat: 41.8781, lon: -87.6298),
        CityModel(cityName: "Houston", lat: 29.7604, lon: -95.3698),
        CityModel(cityName: "Phoenix", lat: 33.4484, lon: -112.0740)
    ]
    static let weatherData = [
        WeatherDataModel(timestamp: Date(timeIntervalSince1970: TimeInterval(1726085048)), humidity: 60, temperature: 312.3, windspeed: 5.0, sunset: 1726105212, sunrise: 1726060173, weatherIcon: "01d", weatherDescription: "Clear sky"),
        WeatherDataModel(timestamp: Date(timeIntervalSince1970: TimeInterval(1726085048)), humidity: 70, temperature: 312.3, windspeed: 6.0, sunset: 1726105212, sunrise: 1726060173, weatherIcon: "01d", weatherDescription: "Partly cloudy"),
        WeatherDataModel(timestamp: Date(timeIntervalSince1970: TimeInterval(1726085048)), humidity: 65, temperature: 312.3, windspeed: 4.5, sunset: 1726105212, sunrise: 1726060173, weatherIcon: "01d", weatherDescription: "Light rain"),
        WeatherDataModel(timestamp: Date(timeIntervalSince1970: TimeInterval(1726085048)), humidity: 50, temperature: 312.3, windspeed: 7.0, sunset: 1726105212, sunrise: 1726060173, weatherIcon: "01d", weatherDescription: "Sunny"),
        WeatherDataModel(timestamp: Date(timeIntervalSince1970: TimeInterval(1726085048)), humidity: 14, temperature: 312.3, windspeed: 0, sunset: 1726105212, sunrise: 1726060173, weatherIcon: "01d", weatherDescription: "Windy")
    ]
    @objc static let CITY_MODEL = "CityModel"
    @objc static let CITY_ENTITY = "City"
    @objc static let CITY_ENTITY_NAME_ATTRIBUTE = "name"
    @objc static let CITY_SEARCH_PREDICATE = "name == [c] %@"
    @objc static let TEMPERATURE = "Temperature"
    @objc static let HUMIDITY = "Humidity"
    @objc static let WIND = "Wind"
    @objc static let SUNSET = "Sunset"
    @objc static let SUNRISE = "Sunrise"
    @objc static let TIME_CONSTANT: Double = 14400
    @objc static let SHOW_WEATHER = "showWeather"
    @objc static let CELL = "Cell"
}

struct ApiConstants {
    static let GET = "GET"
    static let API_KEY = ProcessInfo.processInfo.environment["apiKey"]!
    static let BASE_URL = "https://api.openweathermap.org"
    static let getCoordinatesApiEndPoint = "%@/geo/1.0/direct?q=%@&limit=1&appid=%@"
    static let getWeatherForCoordinatesApiEndPoint = "%@/data/2.5/weather?lat=%@&lon=%@&appid=%@"
    static let fetchImageEndPoint = "%@/img/w/%@.png"
}

@objc class Messages : NSObject {
    @objc static let CITY_NOT_FOUND = "City Not Found"
    @objc static let CITY_NOT_FOUND_MESSAGE = "The city you searched for was not found."
    @objc static let WEATHER_FETCH_FAILED = "Failed to fetch weather data."
    @objc static let ERROR = "Error"
    @objc static let OK = "OK"
    @objc static let WEATHER_DATA_ERROR = "WeatherDataError"
}
