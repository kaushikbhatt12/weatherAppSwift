import CoreData

@objc class CoreDataManager : NSObject {
    @objc static let shared = CoreDataManager()
    
    private override init() {}
    
    @objc func addCities() {
        for (index, city) in AppConstants.cityData.enumerated() {
            CoreDataManager.shared.saveCityData(for: city.cityName, cityData: city) { savedCity in
                if let savedCity = savedCity {
                    // Save the weather data for the city with the timestamp
                    let weatherData = AppConstants.weatherData[index]
                    CoreDataManager.shared.saveWeatherData(for: savedCity.name!, weatherData: weatherData)
                    #if DEBUG
                    print("City and weather data with timestamp saved for \(savedCity.name!)")
                    #endif
                }
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
            #if DEBUG
            print("Failed to fetch city: \(error.localizedDescription)")
            #endif
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
            #if DEBUG
            print("Error saving city data to Core Data: \(error)")
            #endif
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
            weather.timestamp = weatherData.timestamp
            
            city.weather = weather
            
            try context.save()
        } catch {
            #if DEBUG
            print("Error saving weather data to Core Data: \(error)")
            #endif
        }
    }
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: AppConstants.CITY_MODEL)
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                // handle error
                #if DEBUG
                print("Unresolved error \(error), \(error.userInfo)")
                #endif
            }
        }
        return container
    }()
    
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                // handle error
                #if DEBUG
                print("Unresolved error \(nserror), \(nserror.userInfo)")
                #endif
            }
        }
    }
}
