//
//  WeatherDTO.swift
//  WeatherApp
//
//  Created by Julieta Fernandez Irujo on 24/09/2024.
//

import Foundation

struct WeatherDTO: Decodable {
  let dt: TimeInterval
  let weather: [WeatherInfoDTO]
  let main: MainDTO
  let name: String?
}

struct WeatherInfoDTO: Decodable {
  let id: Int
  let main: String
  let description: String
}

struct MainDTO: Decodable {
  let temp: Double
  let feelsLike: Double
  let tempMin: Double
  let tempMax: Double
  
  enum CodingKeys: String, CodingKey {
    case temp
    case feelsLike = "feels_like"
    case tempMin = "temp_min"
    case tempMax = "temp_max"
  }
}
