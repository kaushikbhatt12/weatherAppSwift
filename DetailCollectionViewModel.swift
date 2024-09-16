import Foundation

@objc protocol DetailCollectionViewModelProtocol {
    func fetchWeatherData( cityName: String, latitude: Double, longitude: Double) -> Void
}

@objc class DetailCollectionViewModel: NSObject, DetailCollectionViewModelProtocol {
    
    @objc weak var view : DetailCollectionViewProtocol?
    
    @objc func fetchWeatherData(cityName: String, latitude : Double, longitude: Double) {
        DispatchQueue.global(qos: .background).async {
            WeatherDataManager.shared.getWeatherData(cityName, latitude , longitude) { [weak self] weatherDataModel in
                DispatchQueue.main.async {
                    guard let self = self else { return }
        
                    if let weatherData = weatherDataModel {
                        let weatherCardDataArray = [
                            WeatherCardData(type: CELL_LABEL.TEMPERATURE, value: String(format: " %.1f°C", weatherData.temperature - 273.15), image: URL(string: APIManager.getIconEndPoint(imageParameter: weatherData.weatherIcon)), description: weatherData.weatherDescription),
                            WeatherCardData(type: CELL_LABEL.HUMIDITY, value: "\(CELL_LABEL_TEXT.HUMIDITY) \n \(weatherData.humidity)%", image: nil, description: nil),
                            WeatherCardData(type: CELL_LABEL.WIND, value: "\(CELL_LABEL_TEXT.WIND) \n \(weatherData.windspeed) m/s", image: nil, description: nil),
                            WeatherCardData(type: CELL_LABEL.SUNRISE, value: "\(CELL_LABEL_TEXT.SUNRISE) \n \(formatTime(from: weatherData.sunrise))", image: nil, description: nil),
                            WeatherCardData(type: CELL_LABEL.SUNSET, value: "\(CELL_LABEL_TEXT.SUNSET) \n \(formatTime(from: weatherData.sunset))", image: nil, description: nil)
                        ]
                        self.view?.weatherDataFetched(weatherCardDataArray)
                    } else {
                        self.view?.failedWithError(NSError(domain: Messages.WEATHER_DATA_ERROR, code: -1, userInfo: [NSLocalizedDescriptionKey: Messages.WEATHER_FETCH_FAILED]))
                    }
                }
            }
        }
    }
}
