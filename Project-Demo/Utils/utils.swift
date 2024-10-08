import Foundation

func formatTime(from timestampValue: Int32) -> String {
    let timestamp = TimeInterval(timestampValue)
    let date = Date(timeIntervalSince1970: timestamp)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "hh:mm a"
    return dateFormatter.string(from: date)
}

func getCurrentLanguage() -> String? {
   return Bundle.main.preferredLocalizations.first
}

struct Logger {
    static func debugLog(_ message: String) {
        #if DEBUG
        print("DEBUG: \(message)")
        #endif
    }
}

