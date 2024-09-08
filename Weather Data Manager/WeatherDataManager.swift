//
//  weather-utils.swift
//  Project-Demo
//
//  Created by kaushik.bha on 08/09/24.
//

import Foundation
import CoreData
import UIKit

class WeatherDataManager {
    
    static let shared = WeatherDataManager()
    private init() {}
    
    let networkManager = NetworkManager.shared
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getWeatherData(for cityName: String, completion: @escaping (WeatherDataModel?) -> Void) {
        // check in  core data if weather data for the city is present
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
        fetchRequest.predicate = NSPredicate(format: "name == [c] %@", cityName)
        
        do {
            if let result = try context.fetch(fetchRequest) as? [City], let city = result.first {
                if let currentWeather = city.weather {
                    if isWeatherDataStale(timestamp: currentWeather.timestamp!) {    //  check if cached weather data is less than 4 hours
                        // get data from api
                        fetchDataFromApi(for: cityName) { response in
                            if let response = response {
                                self.saveWeatherDataToCoreData(for:cityName, weatherData: response) // save in core data
                                completion(response)
                            }
                        }
                    } else {
                        let weatherDataModel = WeatherDataModel(
                            timestamp: currentWeather.timestamp!,
                            cityName: city.name!,
                            humidity: String(currentWeather.humidity),
                            temperature: String(currentWeather.temperature),
                            windspeed: String(currentWeather.windspeed)
                        )
                        completion(weatherDataModel)
                    }
                } else {
                    // get data from api
                    fetchDataFromApi(for: cityName) { response in
                        if let response = response {
                            self.saveWeatherDataToCoreData(for:cityName, weatherData: response)  // save in core data
                            completion(response)
                        }
                    }
                }
            }
        } catch {
            print("Failed to fetch weather data: \(error.localizedDescription)")
        }
    }
    
    
    private func isWeatherDataStale(timestamp : Date) -> Bool {
        let timeDifference = Date().timeIntervalSince(timestamp)
        return timeDifference > 14400
    }
    
    func fetchDataFromApi(for cityName: String,completion: @escaping (WeatherDataModel?) -> Void){
        print("api call made")
        networkManager.getCoordinatesForTheCity(for: cityName) { coordinates in
            if let (long,lat) = coordinates {
                self.networkManager.fetchWeatherData(for: long, longitude: lat) { WeatherResponse in
                    if let weatherResponse = WeatherResponse {
                        let weatherDataModel = WeatherDataModel(
                            timestamp: Date(),
                            cityName: cityName,
                            humidity: String(weatherResponse.main.humidity),
                            temperature: String(weatherResponse.main.temp),
                            windspeed: String(weatherResponse.wind.speed)
                        )
                        completion(weatherDataModel)
                    }
                }
            }
        }
    }
      
    private func saveWeatherDataToCoreData(for cityName: String, weatherData: WeatherDataModel) {
        let fetchRequest: NSFetchRequest<City> = City.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == [c] %@", cityName)
        
        do {
            let cities = try context.fetch(fetchRequest)
            let city = cities.first ?? City(context: context)
            city.name = cityName
            
            let weather = WeatherData(context: context)
            weather.temperature = Double(weatherData.temperature)!
            weather.humidity = Double(weatherData.humidity)!
            weather.windspeed = Double(weatherData.windspeed)!
            weather.timestamp = Date()
            
            city.weather = weather
            
            try context.save()
        } catch {
            print("Error saving weather data to Core Data: \(error)")
        }
    }
}
