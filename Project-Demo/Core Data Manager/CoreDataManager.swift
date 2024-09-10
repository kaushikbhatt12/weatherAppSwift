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
        let container = NSPersistentContainer(name: AppConstants.CITY_MODEL)
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                // handle error
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    @objc func addCities() {
        
        let cityNames = AppConstants.cityNames
        for cityName in cityNames {
            let newCity = NSEntityDescription.insertNewObject(forEntityName: AppConstants.CITY_ENTITY, into: context)
            let lowercaseCityName = cityName.lowercased()
            newCity.setValue(lowercaseCityName, forKey: AppConstants.CITY_ENTITY_NAME_ATTRIBUTE)
        }
        
        saveContext()
        print("Cities added successfully")
    }
    
    private func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                // handle error
                print("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    @objc func fetchCity(withName cityName: String, completion: @escaping (City?) -> Void) {
        let fetchRequest: NSFetchRequest<City> = City.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: AppConstants.CITY_SEARCH_PREDICATE, cityName)
        do {
            let cities = try context.fetch(fetchRequest)
            completion(cities.first)
        } catch {
            print("Failed to fetch city: \(error.localizedDescription)")
            completion(nil)
        }
    }
    
    func saveCityData(for cityName: String, cityData: CityModel, completion: @escaping (City?)->Void) {
        let fetchRequest: NSFetchRequest<City> = City.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: AppConstants.CITY_SEARCH_PREDICATE, cityName)
        do {
            let cities = try context.fetch(fetchRequest)
            let city = cities.first ?? City(context: context)
            city.name = cityName
            city.latitude = cityData.lat
            city.longitude = cityData.lon
            
            try context.save()
            completion(city)
        } catch {
            print("Error saving city data to Core Data: \(error)")
            completion(nil)
        }
    }
    
    func saveWeatherData(for cityName: String, weatherData: WeatherDataModel) {
        let fetchRequest: NSFetchRequest<City> = City.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: AppConstants.CITY_SEARCH_PREDICATE, cityName)
        
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
            weather.weatherIcon = weatherData.weatherIcon
            weather.weatherDescription = weatherData.weatherDescription
            weather.timestamp = Date()
            
            city.weather = weather
            
            try context.save()
        } catch {
            print("Error saving weather data to Core Data: \(error)")
        }
    }
}
