//
//  DayForecastModel.swift
//  WeatherApp
//
//  Created by Julieta Fernandez Irujo on 19/03/2025.
//

import struct Foundation.UUID

struct DayForecastModel: WeatherCondition, Identifiable {
  var id: UUID = UUID()
  var day: String
  var conditionId: Int
  var temp: String
}
