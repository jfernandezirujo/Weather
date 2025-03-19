//
//  DayForecastModel.swift
//  WeatherApp
//
//  Created by Julieta Fernandez Irujo on 23/09/2024.
//

struct WeatherModel: WeatherCondition {
  var conditionId: Int
  var temp: String
  var minAndMaxTemp: String
  var location: String
  
  init(
    conditionId: Int = .zero,
    temp: String = "",
    minAndMaxTemp: String = "",
    location: String = ""
  ) {
    self.conditionId = conditionId
    self.temp = temp
    self.minAndMaxTemp = minAndMaxTemp
    self.location = location
  }
}

protocol WeatherCondition {
  var conditionId: Int { get }
  var conditionName: String { get }
}

extension WeatherCondition {
  var conditionName: String {
    switch conditionId {
    case 200...232:
      return "cloud.bolt.fill"
    case 300...321:
      return "cloud.drizzle.fill"
    case 500...531:
      return "cloud.rain.fill"
    case 600...622:
      return "cloud.snow.fill"
    case 701...781:
      return "cloud.fog.fill"
    case 800:
      return "sun.max.fill"
    case 801:
      return "cloud.sun.fill"
    case 802:
      return "cloud"
    case 803...804:
      return "cloud.fill"
    default:
      return "cloud"
    }
  }
}
