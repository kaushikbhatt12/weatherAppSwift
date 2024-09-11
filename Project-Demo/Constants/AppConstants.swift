//
//  AppConstants.swift
//  Project-Demo
//
//  Created by kaushik.bha on 10/09/24.
//

import Foundation

@objc class AppConstants: NSObject {
    @objc static let cityNames: [String] = [
        "London", "Paris", "Berlin", "Madrid", "Rome", "Vienna"
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
