//
//  NetworkManager.swift
//  Project-Demo
//
//  Created by kaushik.bha on 05/09/24.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    struct CityResponse: Codable {
        let lat: Double
        let lon: Double
    }

    func getCoordinatesForTheCity(for cityName: String, completion: @escaping ((Double, Double)?) -> Void) {

        let apiKey = ProcessInfo.processInfo.environment["apiKey"]!

        let apiUrlStr = "http://api.openweathermap.org/geo/1.0/direct?q=\(cityName)&limit=1&appid=\(apiKey)"
      
        guard let url = URL(string: apiUrlStr) else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Invalid response or status code")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let cities = try decoder.decode([CityResponse].self, from: data)
                
                if let firstCity = cities.first {
                    completion((firstCity.lat, firstCity.lon))
                } else {
                    completion(nil)
                }
            } catch {
                print("Parsing error: \(error.localizedDescription)")
                completion(nil)
            }
        }
        
        task.resume()
    }
}
