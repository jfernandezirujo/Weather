//
//  GetCurrentTempUseCase.swift
//  WeatherApp
//
//  Created by Julieta Fernandez Irujo on 26/09/2024.
//

import Combine

struct GetCurrentTempUseCase: GetCurrentTempUseCaseProtocol {
  
  // MARK: - Properties
  private let repository: GetCurrentWeatherRepositoryProtocol
  
  // MARK: - init
  init(repository: GetCurrentWeatherRepositoryProtocol) {
    self.repository = repository
  }
  
  // MARK: - Methods
  func execute() -> AnyPublisher<String, NetworkError> {
    return repository.getTemperature()
      .map { temp in
        return String(format: DomainConstants.decimalFormat, temp)
      }
      .eraseToAnyPublisher()
  }
}

// MARK: - protocol
protocol GetCurrentTempUseCaseProtocol {
  func execute() -> AnyPublisher<String, NetworkError>
}
