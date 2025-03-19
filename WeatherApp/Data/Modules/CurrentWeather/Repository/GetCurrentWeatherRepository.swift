//
//  GetCurrentWeatherRepository.swift
//  WeatherApp
//
//  Created by Julieta Fernandez Irujo on 25/09/2024.
//

import Combine

class GetCurrentWeatherRepository: GetCurrentWeatherRepositoryProtocol {
  
  // MARK: - Properties
  private let apiClient: NetworkingManagerProtocol
  private var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
  private var weatherData: WeatherDTO?
  
  // MARK: - init
  init(apiClient: NetworkingManagerProtocol) {
    self.apiClient = apiClient
  }
  
  // MARK: - Private Methods
  private func fetchWeatherData() -> AnyPublisher<WeatherDTO, NetworkError> {
    return apiClient.getCurrentWeatherData()
      .map { data in
        self.weatherData = data
        return data
      }
      .eraseToAnyPublisher()
  }
  
  // MARK: - Methods
  func getTemperature() -> AnyPublisher<Double, NetworkError> {
    return fetchWeatherData()
      .map { $0.main.feelsLike }
      .eraseToAnyPublisher()
  }
  
  func getWeatherIcon() -> AnyPublisher<WeatherInfoDTO, NetworkError> {
    return fetchWeatherData()
      .map { $0.weather[.zero] }
      .eraseToAnyPublisher()
  }
  
  func getMinTemp() -> AnyPublisher<Int, NetworkError> {
    return fetchWeatherData()
      .map { Int($0.main.tempMin) }
      .eraseToAnyPublisher()
  }
  
  func getMaxTemp() -> AnyPublisher<Int, NetworkError> {
    return fetchWeatherData()
      .map { Int($0.main.tempMax) }
      .eraseToAnyPublisher()
  }
  
  func getLocationName() -> AnyPublisher<String, NetworkError> {
    return fetchWeatherData()
      .compactMap { $0.name  }
      .eraseToAnyPublisher()
  }
}

// MARK: - Protocol
protocol GetCurrentWeatherRepositoryProtocol {
  func getTemperature() -> AnyPublisher<Double, NetworkError>
  func getWeatherIcon() -> AnyPublisher<WeatherInfoDTO, NetworkError>
  func getMinTemp() -> AnyPublisher<Int, NetworkError>
  func getMaxTemp() -> AnyPublisher<Int, NetworkError>
  func getLocationName() -> AnyPublisher<String, NetworkError>
}
