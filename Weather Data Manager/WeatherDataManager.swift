//
//  weather-utils.swift
//  Project-Demo
//
//  Created by kaushik.bha on 08/09/24.
//

import Foundation
import CoreData
import UIKit

class WeatherUtils {
    static let shared = WeatherUtils()
    
    func fetchWeatherData(for cityName: String) -> WeatherData? {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
        
        fetchRequest.predicate = NSPredicate(format: "name ==[c] %@", cityName)
        
        do {
            if let result = try context.fetch(fetchRequest) as? [City], let city = result.first {
                return city.weather
            }
        } catch {
            print("Failed to fetch weather data: \(error.localizedDescription)")
        }
        return nil
    }
    
    func saveWeatherData(for cityName: String, temperature: Double, humidity: Int) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
        
        fetchRequest.predicate = NSPredicate(format: "name ==[c] %@", cityName)
        
        do {
            if let result = try context.fetch(fetchRequest) as? [City], let city = result.first {
                let weatherData = city.weather ?? WeatherData(context: context)
                weatherData.temperature = temperature
                weatherData.humidity = Double(humidity)
                weatherData.timestamp = Date()
                city.weather = weatherData
                
                try context.save()
            }
        } catch {
            print("Failed to save weather data: \(error.localizedDescription)")
        }
    }
    
    func isWeatherDataStale(_ weatherData: WeatherData) -> Bool {
        guard let timestamp = weatherData.timestamp else { return true }
        let currentTime = Date()
        let timeDifference = currentTime.timeIntervalSince(timestamp)
        
        // If data is older than 4 hours (14400 seconds), it is considered stale
        return timeDifference > 14400
    }
}
