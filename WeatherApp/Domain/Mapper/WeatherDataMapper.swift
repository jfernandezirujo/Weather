//
//  WeatherDataMapper.swift
//  WeatherApp
//
//  Created by Julieta Fernandez Irujo on 01/10/2024.
//

import Foundation

struct WeatherDataMapper {
  
  // MARK: - Methods
  static func mapWeatherModel(
    id: Int,
    temp: String,
    minAndMax: String,
    location: String
  ) -> WeatherModel {
    WeatherModel(
      conditionId: id,
      temp: temp,
      minAndMaxTemp: minAndMax,
      location: location
    )
  }
  
  static func mapFiveDaysForecastModel(
    day: String,
    condition: Int,
    temp: String
  ) -> DayForecastModel {
    return DayForecastModel(
      day: day,
      conditionId: condition,
      temp: temp
    )
  }
  
  static func mapFiveDaysForecastModel(
    temperatureData: [String],
    iconData: [Int],
    date: [String]
  ) -> [DayForecastModel] {
    let count: Int = min(
      temperatureData.count,
      iconData.count,
      date.count
    )
    
    return (.zero..<count).compactMap { index in
      let conditionId: Int = iconData[index]
      let day: String = date[index]
      let temperature: String = temperatureData[index]
      return mapFiveDaysForecastModel(
        day: day,
        condition: conditionId,
        temp: temperature
      )
    }
  }
}
