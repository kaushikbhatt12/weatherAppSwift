//
//  WeatherAPIManager.swift
//  Project-Demo
//
//  Created by kaushik.bha on 09/09/24.
//

import Foundation

class APIManager {
    
    static let API_KEY = ApiConstants.API_KEY
    
    static func getCitySearchAPIEndpoint(cityName: String) -> String {
        let apiUrlStr = String(format: ApiConstants.getCoordinatesApiEndPoint,ApiConstants.BASE_URL ,cityName,API_KEY)
        return apiUrlStr
    }

    static func getWeatherAPIEndpoint(latitude: Double, longitude: Double) -> String {
        let apiUrlStr = String(format: ApiConstants.getWeatherForCoordinatesApiEndPoint,ApiConstants.BASE_URL, String(latitude), String(longitude), API_KEY )
        return apiUrlStr
    }
    
    static func getIconEndPoint(imageParameter : String) -> String {
        let apiUrlStr  = String(format: ApiConstants.fetchImageEndPoint,ApiConstants.BASE_URL, imageParameter)
        return apiUrlStr
    }
}
