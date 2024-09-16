import Foundation

struct CityResponse: Codable {
    let name: String
    let lat: Double
    let lon: Double
}

struct CityModel: Codable {
    let cityName: String
    let lat: Double
    let lon: Double
}

struct WeatherDataModel: Codable {
    let timestamp : Date
    let humidity : Int32
    let temperature : Double
    let windspeed : Double
    let sunset : Int32
    let sunrise : Int32
    let weatherIcon : String
    let weatherDescription : String
}

@objc class WeatherCardData: NSObject {
    @objc var type: String
    @objc var value: String
    @objc var image: URL?
    @objc var descriptionText: String?
    
    @objc init(type: String, value: String, image: URL?, description: String?) {
        self.type = type
        self.value = value
        self.image = image
        self.descriptionText = description
    }
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

