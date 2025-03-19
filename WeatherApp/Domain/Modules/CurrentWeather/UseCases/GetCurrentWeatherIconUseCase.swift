//
//  GetCurrentWeatherIconUseCase.swift
//  WeatherApp
//
//  Created by Julieta Fernandez Irujo on 27/09/2024.
//

import Combine

struct GetCurrentWeatherIconUseCase: GetCurrentWeatherIconUseCaseProtocol {
  
  // MARK: - Properties
  private let repository: GetCurrentWeatherRepositoryProtocol
  
  // MARK: - init
  init(repository: GetCurrentWeatherRepositoryProtocol) {
    self.repository = repository
  }
  
  // MARK: - Methods
  func execute() -> AnyPublisher<Int, NetworkError> {
    return repository.getWeatherIcon()
      .map { icon in
        return icon.id
      }
      .eraseToAnyPublisher()
  }
}

// MARK: - protocol
protocol GetCurrentWeatherIconUseCaseProtocol {
  func execute() -> AnyPublisher<Int, NetworkError>
}
