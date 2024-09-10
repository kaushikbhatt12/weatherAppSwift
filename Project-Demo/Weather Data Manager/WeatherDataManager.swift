//
//  weather-utils.swift
//  Project-Demo
//
//  Created by kaushik.bha on 08/09/24.
//

import Foundation
import UIKit

class WeatherDataManager {
    
    static let shared = WeatherDataManager()
    private init() {}
    
    let networkManager = NetworkManager.shared
    let coreDataManager = CoreDataManager.shared
    
    func getWeatherData(for cityName: String, completion: @escaping (WeatherDataModel?) -> Void) {
        // Check in Core Data if weather data for the city is present
        coreDataManager.fetchCity(withName: cityName) { city in
            if let city = city {
                if let currentWeather = city.weather {
                    if self.isWeatherDataStale(timestamp: currentWeather.timestamp!) { // data outdated
                        // Get data from API
                        self.fetchDataFromApi(for: cityName) { response in
                            if let response = response {
                                self.coreDataManager.saveWeatherData(for: cityName, weatherData: response) // Save in Core Data
                                completion(response)
                            }
                        }
                    } else {
                        let weatherDataModel = WeatherDataModel(
                            timestamp: currentWeather.timestamp!,
                            cityName: city.name!,
                            humidity: currentWeather.humidity,
                            temperature: currentWeather.temperature,
                            windspeed: currentWeather.windspeed,
                            sunset: currentWeather.sunset,
                            sunrise: currentWeather.sunrise,
                            weatherIcon: currentWeather.weatherIcon!,
                            weatherDescription: currentWeather.weatherDescription!
                        )
                        completion(weatherDataModel)
                    }
                } else {
                    // Get data from API
                    self.fetchDataFromApi(for: cityName) { response in
                        if let response = response {
                            self.coreDataManager.saveWeatherData(for: cityName, weatherData: response) // Save in Core Data
                            completion(response)
                        }
                    }
                }
            } else {
                // Handle city not found in Core Data
                self.fetchDataFromApi(for: cityName) { response in
                    if let response = response {
                        self.coreDataManager.saveWeatherData(for: cityName, weatherData: response) // Save in Core Data
                        completion(response)
                    }
                }
            }
        }
    }
    
    
    private func isWeatherDataStale(timestamp : Date) -> Bool {
        let timeDifference = Date().timeIntervalSince(timestamp)
        return timeDifference > 14400
    }
    
    func fetchDataFromApi(for cityName: String,completion: @escaping (WeatherDataModel?) -> Void){
        networkManager.getCoordinatesForTheCity(for: cityName) { coordinates in
            if let (long,lat) = coordinates {
                self.networkManager.fetchWeatherData(for: long, longitude: lat) { WeatherResponse in
                    if let weatherResponse = WeatherResponse {
                        let weatherDataModel = WeatherDataModel(
                            timestamp: Date(),
                            cityName: cityName,
                            humidity: Int32(weatherResponse.main.humidity),
                            temperature: weatherResponse.main.temp,
                            windspeed: weatherResponse.wind.speed,
                            sunset: Int32(weatherResponse.sys.sunset),
                            sunrise: Int32(weatherResponse.sys.sunrise),
                            weatherIcon: weatherResponse.weather[0].icon,
                            weatherDescription: weatherResponse.weather[0].main + " - " + weatherResponse.weather[0].description
                        )
                        completion(weatherDataModel)
                    }
                }
            }
        }
    }
}
