//
//  weather-utils.swift
//  Project-Demo
//
//  Created by kaushik.bha on 08/09/24.
//

import Foundation
import UIKit

@objc class WeatherDataManager: NSObject {
    
    @objc static let shared = WeatherDataManager()
    @objc override private init() {}
    
    private let networkManager = NetworkManager.shared
    private let coreDataManager = CoreDataManager.shared
    
    @objc func getCityData(withName cityName: String, completion: @escaping (City?)->Void) {
        coreDataManager.fetchCity(withName: cityName) { city in
            if let city = city {
                // city found in core data
                completion(city)
            } else {
                // api call since city not found in core data
                self.networkManager.fetchCityData(for: cityName) { data in
                    if let (name, latitude, longitude ) = data {
                        if cityName.caseInsensitiveCompare(name) == .orderedSame {
                            let cityData = CityModel(cityName: name, lat: latitude, lon: longitude)
                            self.coreDataManager.saveCityData(for: name, cityData: cityData) { city in
                                if let city = city {
                                    completion(city)
                                }
                            }
                        } else {
                            completion(nil)
                        }
                    } else {
                        // city does not exist
                        completion(nil)
                    }
                }
            }
        }
    }
    
    func getWeatherData(_ cityName: String,_ latitude : Double, _ longitude: Double, completion: @escaping (WeatherDataModel?) -> Void) {
        // Check in Core Data if weather data for the city is present
        coreDataManager.fetchCity(withName: cityName) { city in
            if let city = city {
                if let currentWeather = city.weather {
                    if self.isWeatherDataStale(timestamp: currentWeather.timestamp!) { // data outdated
                        // Get data from API
                        self.fetchDataFromApi(cityName, latitude, longitude) { response in
                            if let response = response {
                                self.coreDataManager.saveWeatherData(for: cityName, weatherData: response) // Save in Core Data
                                completion(response)
                            } else {
                                completion(nil)
                            }
                        }
                    } else {
                        let weatherDataModel = WeatherDataModel(
                            timestamp: currentWeather.timestamp!,
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
                    self.fetchDataFromApi(cityName, latitude, longitude) { response in
                        if let response = response {
                            self.coreDataManager.saveWeatherData(for: cityName, weatherData: response) // Save in Core Data
                            completion(response)
                        } else {
                            completion(nil)
                        }
                    }
                }
            } else {
                // Handle city not found in Core Data
                self.fetchDataFromApi(cityName, latitude, longitude) { response in
                    if let response = response {
                        self.coreDataManager.saveWeatherData(for: cityName, weatherData: response) // Save in Core Data
                        completion(response)
                    }
                    else {
                        completion(nil)
                    }
                }
            }
        }
    }
    
    
    private func isWeatherDataStale(timestamp : Date) -> Bool {
        let timeDifference = Date().timeIntervalSince(timestamp)
        return timeDifference > AppConstants.TIME_CONSTANT
    }
    
    private func fetchDataFromApi(_ cityName: String, _ lat : Double, _ long: Double,completion: @escaping (WeatherDataModel?) -> Void){
        self.networkManager.fetchWeatherData(latitude: lat, longitude: long) { WeatherResponse in
            if let weatherResponse = WeatherResponse {
                let weatherDataModel = WeatherDataModel(
                    timestamp: Date(),
                    humidity: Int32(weatherResponse.main.humidity),
                    temperature: weatherResponse.main.temp,
                    windspeed: weatherResponse.wind.speed,
                    sunset: Int32(weatherResponse.sys.sunset),
                    sunrise: Int32(weatherResponse.sys.sunrise),
                    weatherIcon: weatherResponse.weather[0].icon,
                    weatherDescription: weatherResponse.weather[0].main + " - " + weatherResponse.weather[0].description
                )
                completion(weatherDataModel)
            } else {
                completion(nil)
            }
        }
    }
}
