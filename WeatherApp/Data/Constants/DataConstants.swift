//
//  DataConstants.swift
//  WeatherApp
//
//  Created by Julieta Fernandez Irujo on 24/09/2024.
//

import Foundation

enum DataConstants {
  static let key: String = "93d3218a89b44d876c7869a02268a3ce"
  static let currentWeatherUrl: String =  "https://api.openweathermap.org/data/2.5/weather?appid=%@&units=metric&lat=%@&lon=%@"
  static let forecastUrl: String = "https://api.openweathermap.org/data/2.5/forecast?appid=%@&units=metric&lat=%@&lon=%@"
  static let numberOfArrays: Int = 5
  static let dateFormat: String = "yyyy-MM-dd"
}
