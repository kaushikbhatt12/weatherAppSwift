import Foundation

class APIManager {
    
    private static let API_KEY = ApiConstants.API_KEY
    
    static func getCitySearchAPIEndpoint(cityName: String) -> String {
        let apiUrlStr = String(format: ApiConstants.getCoordinatesApiEndPoint,ApiConstants.BASE_URL ,cityName,API_KEY)
        return apiUrlStr
    }

    static func getWeatherAPIEndpoint(latitude: Double, longitude: Double) -> String {
        if let current_language = getCurrentLanguage() {
            let apiUrlStr = String(format: ApiConstants.getWeatherForCoordinatesApiEndPoint,ApiConstants.BASE_URL, String(latitude), String(longitude),current_language, API_KEY )
            return apiUrlStr
        }
        return ""
    }
    
    static func getIconEndPoint(imageParameter : String) -> String {
        let apiUrlStr  = String(format: ApiConstants.fetchImageEndPoint,ApiConstants.BASE_URL, imageParameter)
        return apiUrlStr
    }
}
