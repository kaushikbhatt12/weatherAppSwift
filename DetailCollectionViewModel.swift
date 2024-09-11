//
//  DetailCollectionViewModel.swift
//  Project-Demo
//
//  Created by kaushik.bha on 10/09/24.
//
import Foundation

protocol DetailCollectionViewModelDelegate: AnyObject {
    func didUpdateWeatherData(_ weatherData: [WeatherCardData])
    func didFailWithError(_ error: Error)
}

class DetailCollectionViewModel {
    
    weak var delegate: DetailCollectionViewModelDelegate?
    
    func fetchWeatherData(cityName: String, latitude : Double, longitude: Double) {
        DispatchQueue.global(qos: .background).async {
            WeatherDataManager.shared.getWeatherData(cityName, latitude , longitude) { [weak self] weatherDataModel in
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    
                    if let weatherData = weatherDataModel {
                        let weatherCardDataArray = [
                            WeatherCardData(type: AppConstants.TEMPERATURE, value: String(format: " %.1f°C", weatherData.temperature - 273.15), image: URL(string: APIManager.getIconEndPoint(imageParameter: weatherData.weatherIcon)), description: weatherData.weatherDescription),
                            WeatherCardData(type: AppConstants.HUMIDITY, value: "Humidity \n \(weatherData.humidity)%", image: nil, description: nil),
                            WeatherCardData(type: AppConstants.WIND, value: "Wind Speed \n \(weatherData.windspeed) m/s", image: nil, description: nil),
                            WeatherCardData(type: AppConstants.SUNRISE, value: "Sunrise \n \(formatTime(from: weatherData.sunrise))", image: nil, description: nil),
                            WeatherCardData(type: AppConstants.SUNSET, value: "Sunset \n \(formatTime(from: weatherData.sunset))", image: nil, description: nil)
                        ]
                        self.delegate?.didUpdateWeatherData(weatherCardDataArray)
                    } else {
                        self.delegate?.didFailWithError(NSError(domain: "WeatherDataError", code: -1, userInfo: [NSLocalizedDescriptionKey: Messages.WEATHER_FETCH_FAILED]))
                    }
                }
            }
        }
    }
}
