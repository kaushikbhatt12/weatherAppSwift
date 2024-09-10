//
//  AppConstants.swift
//  Project-Demo
//
//  Created by kaushik.bha on 10/09/24.
//

import Foundation

struct AppConstants {
    
    static let cityNames: [String] = [
        "London", "Paris", "Berlin", "Madrid", "Rome", "Vienna", "Amsterdam",
        "Brussels", "Stockholm", "Copenhagen", "Oslo", "Helsinki", "Warsaw",
        "Prague", "Budapest", "Zurich", "Milan", "Athens", "Lisbon", "Dublin",
        "Barcelona", "Munich", "Frankfurt", "Edinburgh", "Hamburg", "Lyon",
        "Warsaw", "New York", "Los Angeles", "Chicago", "Houston", "Phoenix", "Philadelphia",
        "San Antonio", "San Diego", "Dallas", "San Jose", "Austin", "Jacksonville",
        "San Francisco", "Seattle", "Denver", "Washington D.C.", "Boston", "Nashville", "Detroit",
        "Oklahoma City", "Portland", "Las Vegas", "Atlanta", "Miami",
        "Tokyo", "Osaka", "Seoul", "Busan", "Shanghai", "Beijing", "Shenzhen",
        "Guangzhou", "Hong Kong", "Taipei", "Wuhan", "Mumbai", "Delhi", "Bangalore",
        "Chennai", "Hyderabad", "Kolkata",
        "Ahmedabad", "Pune", "Jaipur", "Lucknow", "Kanpur", "Nagpur", "Indore",
        "Patna", "Bhopal", "Ludhiana", "Agra", "Nashik", "Vadodara", "Meerut",
        "Rajkot", "Varanasi", "Srinagar", "Aurangabad", "Dhanbad", "Amritsar",
        "Navi Mumbai", "Allahabad", "Gwalior", "Jabalpur", "Coimbatore",
        "Vijayawada", "Jodhpur", "Madurai", "Raipur", "Chandigarh", "Guwahati",
        "Mysore", "Tiruchirappalli", "Tiruppur", "Salem", "Warangal", "Mangalore"
    ]
    
    static let CITY_MODEL = "CityModel"
    static let CITY_ENTITY = "City"
    static let CITY_ENTITY_NAME_ATTRIBUTE = "name"
    static let CITY_SEARCH_PREDICATE = "name == [c] %@"
}


struct ApiConstants {
    static let GET = "GET"
    static let API_KEY = ProcessInfo.processInfo.environment["apiKey"]!
    static let getCoordinatesApiEndPoint = "http://api.openweathermap.org/geo/1.0/direct?q=%@&limit=1&appid=%@"
    static let getWeatherForCoordinatesApiEndPoint = "https://api.openweathermap.org/data/2.5/weather?lat=%@&lon=%@&appid=%@"
}

@objc class Messages : NSObject {
    @objc static let CITY_NOT_FOUND = "City Not Found"
    @objc static let CITY_NOT_FOUND_MESSAGE = "The city you searched for was not found."
    @objc static let WEATHER_FETCH_FAILED = "Failed to fetch weather data."
    @objc static let ERROR = "Error"
    @objc static let OK = "OK"
}
