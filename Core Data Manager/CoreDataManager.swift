//
//  CoreDataManager.swift
//  Project-Demo
//
//  Created by kaushik.bha on 09/09/24.
//

import CoreData

@objc class CoreDataManager : NSObject {
    @objc static let shared = CoreDataManager()
    
    private override init() {}
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CityModel")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                // handle error
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    @objc func addCities() {
        
        if let cityNames = AppConstants.cityNames() as? [String] {
            for cityName in cityNames {
                let newCity = NSEntityDescription.insertNewObject(forEntityName: "City", into: context)
                let lowercaseCityName = cityName.lowercased()
                newCity.setValue(lowercaseCityName, forKey: "name")
            }
            
            saveContext()
            print("Cities added successfully")
        }
    }
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                // handle error
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchCity(withName cityName: String, completion: @escaping (City?) -> Void) {
        let fetchRequest: NSFetchRequest<City> = City.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == [c] %@", cityName)
        
        do {
            let cities = try context.fetch(fetchRequest)
            completion(cities.first)
        } catch {
            print("Failed to fetch city: \(error.localizedDescription)")
            completion(nil)
        }
    }
    
    func saveWeatherData(for cityName: String, weatherData: WeatherDataModel) {
        let fetchRequest: NSFetchRequest<City> = City.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == [c] %@", cityName)
        
        do {
            let cities = try context.fetch(fetchRequest)
            let city = cities.first ?? City(context: context)
            city.name = cityName
            
            let weather = WeatherData(context: context)
            weather.temperature = weatherData.temperature
            weather.humidity = Int32(weatherData.humidity)
            weather.windspeed = weatherData.windspeed
            weather.sunset = Int32(weatherData.sunset)
            weather.sunrise = Int32(weatherData.sunrise)
            weather.timestamp = Date()
            
            city.weather = weather
            
            try context.save()
        } catch {
            print("Error saving weather data to Core Data: \(error)")
        }
    }
}
