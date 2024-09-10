//
//  AppConstants.swift
//  Project-Demo
//
//  Created by kaushik.bha on 10/09/24.
//

import Foundation

struct AppConstants {
    
    static let cityNames: [String] = [
        "London", "Paris", "Berlin", "Madrid", "Rome", "Vienna"
    ]
    
    static let CITY_MODEL = "CityModel"
    static let CITY_ENTITY = "City"
    static let CITY_ENTITY_NAME_ATTRIBUTE = "name"
    static let CITY_SEARCH_PREDICATE = "name == [c] %@"
}


struct ApiConstants {
    static let GET = "GET"
    static let API_KEY = ProcessInfo.processInfo.environment["apiKey"]!
    static let BASE_URL = "https://api.openweathermap.org"
    static let getCoordinatesApiEndPoint = "\(BASE_URL)/geo/1.0/direct?q=%@&limit=1&appid=%@"
    static let getWeatherForCoordinatesApiEndPoint = "\(BASE_URL)/data/2.5/weather?lat=%@&lon=%@&appid=%@"
    static let fetchImageEndPoint = "\(BASE_URL)/img/w/%@.png"
}

@objc class Messages : NSObject {
    @objc static let CITY_NOT_FOUND = "City Not Found"
    @objc static let CITY_NOT_FOUND_MESSAGE = "The city you searched for was not found."
    @objc static let WEATHER_FETCH_FAILED = "Failed to fetch weather data."
    @objc static let ERROR = "Error"
    @objc static let OK = "OK"
}
