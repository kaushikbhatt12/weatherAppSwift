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
                    Logger.debugLog("\(Messages.SAVED_WEATHER_AND_CITY_DATA) \(savedCity.name!)")
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
            Logger.debugLog("\(Messages.FAILED_FETCH) \(error.localizedDescription)")
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
            Logger.debugLog("\(Messages.ERROR_SAVING_CITY_DATA) \(error)")
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
            Logger.debugLog("\(Messages.ERROR_SAVING_WEATHER_DATA) \(error)")
        }
    }
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: AppConstants.CITY_MODEL)
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                // handle error
                Logger.debugLog("\(Messages.UNRESOLVED_ERROR) \(error), \(error.userInfo)")
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
                Logger.debugLog("\(Messages.UNRESOLVED_ERROR) \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
