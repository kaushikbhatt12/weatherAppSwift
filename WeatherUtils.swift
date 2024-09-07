//
//  WeatherUtils.swift
//  Project-Demo
//
//  Created by kaushik.bha on 05/09/24.
//
import Foundation
import CoreData
import UIKit

func fetchWeatherDataForCity(cityName: String, completion: @escaping (WeatherData?) -> Void) {
    if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
        let managedContext = appDelegate.persistentContainer.viewContext
        let cityFetchRequest: NSFetchRequest<City> = City.fetchRequest()
        cityFetchRequest.predicate = NSPredicate(format: "name == %@", cityName)
        
        do {
            let cities = try managedContext.fetch(cityFetchRequest)
            
            if let city = cities.first
            {
                if let weatherData = city.weather {
                    // Check if the weather data is outdated (older than 4 hours)
                    if let timestamp = weatherData.timestamp, Date().timeIntervalSince(timestamp) < 14400 {
                        // Data is valid, return stored weather data
                        completion(weatherData)
                        return
                    }
                }
            }
            
            
            // Fetch new weather data via API if outdated or not present
            
            let networkManager = NetworkManager.shared
            
            networkManager.getCoordinatesForTheCity(for: cityName) { coordinates in
                guard let (latitude, longitude) = coordinates else {
                    completion(nil)
                    return
                }
                
                networkManager.fetchWeatherData(for: latitude, longitude: longitude) { weatherResponse in
                    if let weatherResponse = weatherResponse {
                        // Create or update WeatherData in Core Data
                        if let city = cities.first {
                            let weatherData = city.weather ?? WeatherData(from: managedContext as! Decoder)
                            weatherData.temperature = weatherResponse.main.temp
                            weatherData.humidity = weatherResponse.main.humidity
                            weatherData.windSpeed = weatherResponse.wind.speed
                            weatherData.timestamp = Date() // Store current timestamp
                            
                            city.weatherData = weatherData
                            
                            do {
                                try managedContext.save()
                            } catch {
                                print("Failed to save weather data: \(error)")
                            }
                            
                            completion(weatherData)
                        }
                    } else {
                        completion(nil)
                    }
                }
            }
            
        } catch {
            print("Failed to fetch city: \(error)")
            completion(nil)
        }
    }
}



