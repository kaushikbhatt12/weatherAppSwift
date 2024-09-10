//
//  WeatherAPIManager.swift
//  Project-Demo
//
//  Created by kaushik.bha on 09/09/24.
//

import Foundation

class APIManager {
    
    static let API_KEY = AppConstants.API_KEY
    
    static func getCitySearchAPIEndpoint(cityName: String) -> String {
        let apiUrlStr = String(format: AppConstants.getCoordinatesApiEndPoint,cityName,API_KEY)
        return apiUrlStr
    }

    static func getWeatherAPIEndpoint(latitude: Double, longitude: Double) -> String {
        let apiUrlStr = String(format: AppConstants.getWeatherForCoordinatesApiEndPoint, String(latitude), String(longitude), API_KEY )
        return apiUrlStr
    }
}
