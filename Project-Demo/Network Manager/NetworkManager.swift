import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    func fetchCityData(for cityName: String, completion: @escaping ((String, Double, Double)?) -> Void) {
        let apiUrlStr = APIManager.getCitySearchAPIEndpoint(cityName: cityName)
        
        guard let url = URL(string: apiUrlStr) else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = ApiConstants.GET
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(nil)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(nil)
                return
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let cities = try decoder.decode([CityResponse].self, from: data)
                
                if let firstCity = cities.first {
                    completion((firstCity.name, firstCity.lat, firstCity.lon))
                } else {
                    completion(nil)
                }
            } catch {
                completion(nil)
            }
        }
        
        task.resume()
    }
    
    func fetchWeatherData(latitude:Double, longitude: Double, completion: @escaping (WeatherResponse?) -> Void) {
        
        let apiUrlStr = APIManager.getWeatherAPIEndpoint(latitude: latitude, longitude: longitude)
        
        guard let url = URL(string: apiUrlStr) else {
            completion(nil)
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(nil)
                return
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let weatherResponse = try decoder.decode(WeatherResponse.self, from: data)
                completion(weatherResponse)
            } catch {
                completion(nil)
            }
        }
        task.resume()
    }
}
