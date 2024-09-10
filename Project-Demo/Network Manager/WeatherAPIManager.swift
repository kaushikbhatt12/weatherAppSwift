//
//  WeatherAPIManager.swift
//  Project-Demo
//
//  Created by kaushik.bha on 09/09/24.
//

import Foundation

class APIManager {
    
    static let apiKey = ProcessInfo.processInfo.environment["apiKey"]!
    
    static func getCitySearchAPIEndpoint(cityName: String) -> String {
        let apiUrlStr = "http://api.openweathermap.org/geo/1.0/direct?q=\(cityName)&limit=1&appid=\(apiKey)"
        return apiUrlStr
    }

    static func getWeatherAPIEndpoint(latitude: Double, longitude: Double) -> String {
        let apiUrlStr = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)"
        return apiUrlStr
    }
}
