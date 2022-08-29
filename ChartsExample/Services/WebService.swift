//
//  WebService.swift
//  ChartsExample
//
//  Created by Tim Owings on 8/9/22.
//

import Foundation

class Webservice: NSObject, ObservableObject {
    
    let aqiURL = "https://api.waqi.info/feed/here/?token="
    
    let token = "" // Token goes here....
    
    
    func getAirQualityForecast() -> (Array<O3>, Array<O3>) {
        
        var pm10 = [O3]()
        var pm25 = [O3]()
        
        if (token == "") {
            print("getAirQualityForecast: Error: Empty Token")
            return (pm10, pm25)
        }
        
        guard let url = URL(string: aqiURL + token) else {
            print("getAirQualityForecast: error: cannot create getAirQualityForecast URL")
            return (pm10, pm25)
        }
        
        let request = URLRequest(url: url)
        
        let semaphore: DispatchSemaphore = DispatchSemaphore(value: 0)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let data = data {
                
                do {
                    
                    let decodedResponse = try JSONDecoder().decode(AirQualityForecast.self, from: data)
                    
                    pm10 = decodedResponse.data.forecast.daily.pm10

                    pm25 = decodedResponse.data.forecast.daily.pm25

                    semaphore.signal()
                    
                } catch let jsonError as NSError {
                    print("JSON decode failed: \(jsonError)")
                }
            }
        }
        
        task.resume()
        
        semaphore.wait()
        
        return (pm10, pm25)
    }
}
