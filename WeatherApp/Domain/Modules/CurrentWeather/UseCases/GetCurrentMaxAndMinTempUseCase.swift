//
//  GetCurrentMaxAndMinTempUseCase.swift
//  WeatherApp
//
//  Created by Julieta Fernandez Irujo on 02/10/2024.
//

import Combine

struct GetCurrentMaxAndMinTempUseCase: GetCurrentMaxAndMinTempUseCaseProtocol {

  // MARK: - Properties
  private let repository: GetCurrentWeatherRepositoryProtocol

  // MARK: - init
  init(repository: GetCurrentWeatherRepositoryProtocol) {
    self.repository = repository
  }

  // MARK: - Methods
  func execute() -> AnyPublisher<String, NetworkError>  {
    let min: AnyPublisher<Int, NetworkError> = repository.getMinTemp()
    let max: AnyPublisher<Int, NetworkError> = repository.getMaxTemp()

    return Publishers.Zip(min, max)
      .map { minValue, maxValue in
        return "\(minValue)\(PresentationConstants.degreeSymbol) / \(maxValue)\(PresentationConstants.degreeSymbol)"
      }
      .eraseToAnyPublisher()
  }
}

// MARK: - protocol
protocol GetCurrentMaxAndMinTempUseCaseProtocol {
  func execute() -> AnyPublisher<String, NetworkError>
}
