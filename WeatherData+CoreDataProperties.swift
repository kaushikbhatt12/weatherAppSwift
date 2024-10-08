import Foundation
import CoreData


extension WeatherData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherData> {
        return NSFetchRequest<WeatherData>(entityName: "WeatherData")
    }

    @NSManaged public var humidity: Int32
    @NSManaged public var sunrise: Int32
    @NSManaged public var sunset: Int32
    @NSManaged public var temperature: Double
    @NSManaged public var timestamp: Date?
    @NSManaged public var weatherDescription: String?
    @NSManaged public var weatherIcon: String?
    @NSManaged public var windspeed: Double
    @NSManaged public var weather: City?

}

extension WeatherData : Identifiable {

}
