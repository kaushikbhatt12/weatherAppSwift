//
//  City+CoreDataProperties.swift
//  Project-Demo
//
//  Created by kaushik.bha on 08/09/24.
//
//

import Foundation
import CoreData


extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City")
    }

    @NSManaged public var name: String?
    @NSManaged public var weather: WeatherData?

}

extension City : Identifiable {

}
