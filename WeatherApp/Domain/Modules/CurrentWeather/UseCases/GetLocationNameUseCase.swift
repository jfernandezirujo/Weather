//
//  GetLocationNameUseCase.swift
//  WeatherApp
//
//  Created by Julieta Fernandez Irujo on 08/10/2024.
//

import Combine

struct GetLocationNameUseCase: GetLocationNameUseCaseProtocol {
  
  // MARK: - Properties
  private let repository: GetCurrentWeatherRepositoryProtocol
  
  // MARK: - init
  init(repository: GetCurrentWeatherRepositoryProtocol) {
    self.repository = repository
  }
  
  // MARK: - Methods
  func execute() -> AnyPublisher<String, NetworkError> {
    return repository.getLocationName()
      .map { temp in
        return temp
      }
      .eraseToAnyPublisher()
  }
}

// MARK: - protocol
protocol GetLocationNameUseCaseProtocol {
  func execute() -> AnyPublisher<String, NetworkError>
}
