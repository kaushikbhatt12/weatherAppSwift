//
//  WeatherData+CoreDataProperties.swift
//  Project-Demo
//
//  Created by kaushik.bha on 08/09/24.
//
//

import Foundation
import CoreData


extension WeatherData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherData> {
        return NSFetchRequest<WeatherData>(entityName: "WeatherData")
    }

    @NSManaged public var humidity: Double
    @NSManaged public var temperature: Double
    @NSManaged public var timestamp: Date?
    @NSManaged public var windspeed: Double
    @NSManaged public var weather: City?

}

extension WeatherData : Identifiable {

}
