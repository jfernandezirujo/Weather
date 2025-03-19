//
//  NetworkingManager.swift
//  WeatherApp
//
//  Created by Julieta Fernandez Irujo on 24/09/2024.
//

import Combine
import Foundation

struct NetworkingManager: NetworkingManagerProtocol {
  
  // MARK: - Properties
  private var locationManager: LocationManagerProtocol
  
  // MARK: - init
  init(locationManager: LocationManagerProtocol) {
    self.locationManager = locationManager
  }
  
  // MARK: - Private methodes
  private func fetchData<T: Decodable>(
    from urlString: String,
    decodeTo type: T.Type
  ) -> AnyPublisher<T, NetworkError> {

    guard let url: URL = URL(string: urlString) else {
      return Fail(error: NetworkError.invalidURL)
        .eraseToAnyPublisher()
    }
    
    return URLSession.shared.dataTaskPublisher(for: url)
      .mapError { NetworkError.networkError($0) }
      .map { $0.data }
      .decode(
        type: T.self,
        decoder: JSONDecoder()
      )
      .receive(on: DispatchQueue.main)
      .mapError { NetworkError.decodingError($0) }
      .eraseToAnyPublisher()
  }
  
  // MARK: - Methodes
  func getCurrentWeatherData() -> AnyPublisher<WeatherDTO, NetworkError> {
    let apiKey: String = DataConstants.key
    return locationManager.getCurrentLocation()
      .first()
      .flatMap { location -> AnyPublisher<WeatherDTO, NetworkError> in
        let urlString: String = String(format: DataConstants.currentWeatherUrl, apiKey, "\(location.latitude)", "\(location.longitude)")
        return self.fetchData(
          from: urlString,
          decodeTo: WeatherDTO.self
        )
      }
      .eraseToAnyPublisher()
  }
  
  func getFiveDaysForecastData() -> AnyPublisher<ForecastDTO, NetworkError> {
    let apiKey: String = DataConstants.key
    return locationManager.getCurrentLocation()
      .flatMap { location -> AnyPublisher<ForecastDTO, NetworkError> in
        let urlString: String = String(format: DataConstants.forecastUrl, apiKey, "\(location.latitude)", "\(location.longitude)")
        return self.fetchData(
          from: urlString,
          decodeTo: ForecastDTO.self
        )
      }
      .eraseToAnyPublisher()
  }
}

// MARK: - Protocol
protocol NetworkingManagerProtocol {
  func getCurrentWeatherData() -> AnyPublisher<WeatherDTO, NetworkError>
  func getFiveDaysForecastData() -> AnyPublisher<ForecastDTO, NetworkError>
}
