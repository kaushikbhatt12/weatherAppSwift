import Foundation

@objc class AppConstants: NSObject {
    static let cityData = [
        CityModel(cityName: "New York", lat: 40.7127281, lon: -74.0060152),
        CityModel(cityName: "Los Angeles", lat: 34.0536909, lon: -118.242766),
        CityModel(cityName: "Chicago", lat: 41.8755616, lon: -87.6244212)
    ]
    static let weatherData = [
        WeatherDataModel(timestamp: Date(timeIntervalSince1970: TimeInterval(1726085048)), humidity: 60, temperature: 312.3, windspeed: 5.0, sunset: 1726105212, sunrise: 1726060173, weatherIcon: "01d", weatherDescription: "Clear sky"),
        WeatherDataModel(timestamp: Date(timeIntervalSince1970: TimeInterval(1726085048)), humidity: 70, temperature: 312.3, windspeed: 6.0, sunset: 1726105212, sunrise: 1726060173, weatherIcon: "01d", weatherDescription: "Partly cloudy"),
        WeatherDataModel(timestamp: Date(timeIntervalSince1970: TimeInterval(1726085048)), humidity: 65, temperature: 312.3, windspeed: 4.5, sunset: 1726105212, sunrise: 1726060173, weatherIcon: "01d", weatherDescription: "Light rain")
    ]
    @objc static let CITY_MODEL = "CityModel"
    @objc static let CITY_ENTITY = "City"
    @objc static let CITY_ENTITY_NAME_ATTRIBUTE = "name"
    @objc static let CITY_SEARCH_PREDICATE = "name == [c] %@"
    @objc static let TIME_CONSTANT: Double = 14400
    @objc static let SHOW_WEATHER = "showWeather"
    @objc static let CELL = "Cell"
    @objc static let CITY_NOT_FOUND = "CityNotFound"
    @objc static let FONT_STYLE = "Noteworthy-Bold"
    @objc static let STORY_BOARD_NAME = "Main"
    @objc static let FONT_SIZE = 20
    @objc static let TEMPERATURE_CONSTANT : CGFloat = 273.15
    @objc static let LOGIN_SIGNUP_CONTROLLER = "LoginSignupViewController"
    @objc static let HOME_NAVIGATION_VIEW_CONTROLLER = "HomeNavigationViewController"
    @objc static let BACK_ICON = "✖️"
}

@objc class CELL_LABEL: NSObject {
    @objc static let TEMPERATURE = "Temperature"
    @objc static let HUMIDITY = "Humidity"
    @objc static let WIND = "Wind"
    @objc static let SUNSET = "Sunset"
    @objc static let SUNRISE = "Sunrise"
}

@objc class CELL_LABEL_TEXT: NSObject {
    @objc static let HUMIDITY = NSLocalizedString("Humidity",comment: "")
    @objc static let WIND = NSLocalizedString("Wind",comment: "")
    @objc static let SUNSET = NSLocalizedString("Sunset",comment: "")
    @objc static let SUNRISE = NSLocalizedString("Sunrise",comment: "")
    @objc static let GET_WEATHER = NSLocalizedString("Get Weather",comment: "")
}

struct ApiConstants {
    static let GET = "GET"
    static let API_KEY = ProcessInfo.processInfo.environment["apiKey"]!
    static var BASE_URL: String {
        if let urlsDict = Bundle.main.object(forInfoDictionaryKey: "URLs") as? [String: Any],
           let baseURL = urlsDict["baseURL"] as? String {
            return baseURL
        }
        return ""
    }
    static let getCoordinatesApiEndPoint = "%@/geo/1.0/direct?q=%@&limit=1&appid=%@"
    static let getWeatherForCoordinatesApiEndPoint = "%@/data/2.5/weather?lat=%@&lon=%@&lang=%@&appid=%@"
    static let fetchImageEndPoint = "%@/img/w/%@.png"
}

@objc class Messages : NSObject {
    @objc static let CITY_NOT_FOUND = NSLocalizedString("City Not Found",comment: "")
    @objc static let CITY_NOT_FOUND_MESSAGE = NSLocalizedString("The city you searched for was not found.",comment: "")
    @objc static let WEATHER_FETCH_FAILED = NSLocalizedString("Failed to fetch weather data.",comment: "")
    @objc static let ERROR = NSLocalizedString("Error",comment: "")
    @objc static let OK = NSLocalizedString("OK",comment: "")
    @objc static let WEATHER_DATA_ERROR = NSLocalizedString("WeatherDataError",comment: "")
    @objc static let NO_CITY_ENTERED = NSLocalizedString("Please enter a city name",comment: "")
    @objc static let UNRESOLVED_ERROR = "Unresolved error"
    @objc static let ERROR_SAVING_WEATHER_DATA = "Error saving weather data to Core Data:"
    @objc static let ERROR_SAVING_CITY_DATA = "Error saving city data to Core Data:"
    @objc static let FAILED_FETCH = "Failed to fetch city:"
    @objc static let SAVED_WEATHER_AND_CITY_DATA = "City and weather data with timestamp saved for"
    @objc static let FAILED_LOG_OUT = NSLocalizedString("Failed to log out.",comment: "")
    @objc static let ENTER_EMAIL = NSLocalizedString("Enter email",comment: "")
    @objc static let ENTER_PASSWORD = NSLocalizedString("Enter password",comment: "")
    @objc static let LOGIN = NSLocalizedString("Login",comment: "")
    @objc static let SIGNUP = NSLocalizedString("Signup",comment: "")
    @objc static let ENTER_EMAIL_AND_PASSWORD = NSLocalizedString("Please enter both email and password",comment: "")
}

@objc class LAYOUT_CONSTANTS : NSObject {
    @objc static let CORNER_RADIUS : CGFloat = 10
    @objc static let CELL_SPACING : CGFloat = 10
    @objc static let CELL_INSETS : CGFloat = 10
    @objc static let MINIMUM_LINE_SPACING : CGFloat = 10
    @objc static let MINIMUM_INTER_ITEM_SPACING : CGFloat = 10
}

@objc class IMAGE_CONSTANTS: NSObject {
    @objc static let HUMIDITY = "humidity"
    @objc static let SUNRISE = "sunrise"
    @objc static let SUNSET = "sunset"
    @objc static let WIND = "wind"
    @objc static let WEATHER_INFO = "weatherInfo"
}
