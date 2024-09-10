//
//  dataTypes.swift
//  Project-Demo
//
//  Created by kaushik.bha on 05/09/24.
//

import Foundation

struct CityModel: Codable {
    let cityName: String
    let lat: Double
    let lon: Double
}

struct WeatherDataModel: Codable {
    let timestamp : Date
    let cityName : String
    let humidity : Int32
    let temperature : Double
    let windspeed : Double
    let sunset : Int32
    let sunrise : Int32
    let weatherIcon : String
    let weatherDescription : String
}

struct WeatherCardData {
    let type: String
    let value: String
    let image: String?
    let description: String?
}

struct WeatherResponse: Codable {
    let coord: Coord
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let sys: Sys
    let name: String
}

struct Coord: Codable {
    let lon: Double
    let lat: Double
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
}

struct Sys: Codable {
    let country: String
    let sunrise: Int
    let sunset: Int
}

