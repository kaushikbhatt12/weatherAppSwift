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
    
    func fetchWeatherData(for cityName: String) {
        WeatherDataManager.shared.getWeatherData(for: cityName) { [weak self] weatherDataModel in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                if let weatherData = weatherDataModel {
                    let weatherCardDataArray = [
                        WeatherCardData(type: "Temperature", value: "\(weatherData.temperature)", image: weatherData.weatherIcon, description: weatherData.weatherDescription),
                        WeatherCardData(type: "Humidity", value: "\(weatherData.humidity)", image: nil, description: nil),
                        WeatherCardData(type: "Wind", value: "\(weatherData.windspeed)", image: nil, description: nil),
                        WeatherCardData(type: "Sunrise", value: "\(weatherData.sunrise)", image: nil, description: nil),
                        WeatherCardData(type: "Sunset", value: "\(weatherData.sunset)", image: nil, description: nil)
                    ]
                    self.delegate?.didUpdateWeatherData(weatherCardDataArray)
                } else {
                    self.delegate?.didFailWithError(NSError(domain: "WeatherDataError", code: -1, userInfo: [NSLocalizedDescriptionKey: Messages.WEATHER_FETCH_FAILED]))
                }
            }
        }
    }
}
