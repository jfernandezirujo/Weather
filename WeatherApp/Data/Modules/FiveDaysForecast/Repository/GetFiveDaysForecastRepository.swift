//
//  GetFiveDaysForecastRepository.swift
//  WeatherApp
//
//  Created by Julieta Fernandez Irujo on 28/09/2024.
//

import Combine
import Foundation

class GetFiveDaysForecastRepository: GetFiveDaysForecastRepositoryProtocol {
  
  // MARK: - Properties
  private let apiClient: NetworkingManagerProtocol
  private let dateHelper: DateHelper

  // MARK: - init
  init(
    apiClient: NetworkingManagerProtocol,
    dateHelper: DateHelper
  ) {
    self.apiClient = apiClient
    self.dateHelper = dateHelper
  }

  // MARK: - Methods
  func getTemperature() -> AnyPublisher<[[Double]], NetworkError> {
    var temperatureArray: [[Double]] = Array(
      repeating: [],
      count: DataConstants.numberOfArrays
    )
    var groupedTemperatures: [String: [Double]] = [:]
    return apiClient.getFiveDaysForecastData()
      .map { data in
        let dates: [WeatherDTO] = self.dateHelper.removeToday(from: data.list)
        for weather in dates {
          let date: Date = self.dateHelper.formatTimeInterval(with: weather.dt)
          let dayKey: String = self.dateHelper.formatDate(
            date: date,
            format: DataConstants.dateFormat
          )
          if groupedTemperatures[dayKey] != nil {
            groupedTemperatures[dayKey]?.append(weather.main.temp)
          } else {
            groupedTemperatures[dayKey] = [weather.main.temp]
          }
          
        }
        let sortedKeys: [String] = groupedTemperatures.keys.sorted()
        for (index, key) in sortedKeys.enumerated() {
          if index < temperatureArray.count {
            temperatureArray[index] = groupedTemperatures[key] ?? []
          }
        }
        return temperatureArray
        
      }
      .eraseToAnyPublisher()
  }
  
  func getWeatherIcon() -> AnyPublisher<[[Int]], NetworkError> {
    var weatherIconArray: [[Int]] = Array(
      repeating: [],
      count: DataConstants.numberOfArrays
    )
    var groupedWeatherIcons: [String: [Int]] = [:]
    
    return apiClient.getFiveDaysForecastData()
      .map { data in
        let dates: [WeatherDTO] = self.dateHelper.removeToday(from: data.list)
        
        for weather in dates {
          let date: Date = self.dateHelper.formatTimeInterval(with: weather.dt)
          let dayKey: String = self.dateHelper.formatDate(
            date: date,
            format: DataConstants.dateFormat
          )
          
          if let weatherID: Int = weather.weather.first?.id {
            if groupedWeatherIcons[dayKey] != nil {
              groupedWeatherIcons[dayKey]?.append(weatherID)
            } else {
              groupedWeatherIcons[dayKey] = [weatherID]
            }
          }
        }
        
        let sortedKeys: [String] = groupedWeatherIcons.keys.sorted()
        
        for (index, key) in sortedKeys.enumerated() {
          if index < weatherIconArray.count {
            weatherIconArray[index] = groupedWeatherIcons[key] ?? []
          }
        }
        
        return weatherIconArray
      }
      .mapError { error in
        return NetworkError.generic
      }
      .eraseToAnyPublisher()
  }
  
}

// MARK: - Protocol
protocol GetFiveDaysForecastRepositoryProtocol {
  func getTemperature() -> AnyPublisher<[[Double]], NetworkError>
  func getWeatherIcon() -> AnyPublisher<[[Int]], NetworkError>
}
