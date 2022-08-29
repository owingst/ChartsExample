// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let airQualityForecast = try? newJSONDecoder().decode(AirQualityForecast.self, from: jsonData)

// Had to modify iso and sync variables to be String instead of Date
// po String(data: yourDataVariable as! Data, encoding: String.Encoding.utf8) to see Data blob in xcode
import Foundation

// MARK: - AirQualityForecast
struct AirQualityForecast: Codable {
    let status: String
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let aqi, idx: Int
    let attributions: [Attribution]
    let city: City
    let dominentpol: String
    let iaqi: Iaqi
    let time: Time
    let forecast: Forecast
    let debug: Debug
}

// MARK: - Attribution
struct Attribution: Codable {
    let url: String
    let name: String
    let logo: String?
}

// MARK: - City
struct City: Codable {
    let geo: [Double]
    let name: String
    let url: String
    let location: String
}

// MARK: - Debug
struct Debug: Codable {
    //let sync: Date  Fix to quicktype model generated from json
    let sync: String
}

// MARK: - Forecast
struct Forecast: Codable {
    let daily: Daily
}

// MARK: - Daily
struct Daily: Codable {
    let o3, pm10, pm25, uvi: [O3]
}

// MARK: - O3
struct O3: Codable, Hashable {
    let avg: Int
    let day: String
    let max, min: Int
}

// MARK: - Iaqi
struct Iaqi: Codable {
    let h, o3, p, t: H
    let w, wg: H
}

// MARK: - H
struct H: Codable {
    let v: Double
}

// MARK: - Time
struct Time: Codable {
    let s, tz: String
    let v: Int
    //let iso: Date  Fix to quicktype model generated from json
    let iso: String
}
