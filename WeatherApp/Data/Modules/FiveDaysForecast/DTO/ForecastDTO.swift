//
//  ForecastDTO.swift
//  WeatherApp
//
//  Created by Julieta Fernandez Irujo on 18/03/2025.
//

struct ForecastDTO: Decodable {
  let list: [WeatherDTO]
}
