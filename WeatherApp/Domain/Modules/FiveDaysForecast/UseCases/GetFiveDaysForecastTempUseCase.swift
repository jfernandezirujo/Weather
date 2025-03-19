//
//  GetFiveDaysForecastTempUseCase.swift
//  WeatherApp
//
//  Created by Julieta Fernandez Irujo on 29/09/2024.
//

import Combine

struct GetFiveDaysForecastTempUseCase: GetFiveDaysForecastTempUseCaseProtocol {
  
  // MARK: - Properties
  private let repository: GetFiveDaysForecastRepositoryProtocol
  
  // MARK: - init
  init(repository: GetFiveDaysForecastRepositoryProtocol) {
    self.repository = repository
  }
  
  // MARK: - Methods
  func execute() -> AnyPublisher<[String], NetworkError> {
    return repository.getTemperature()
      .map { tempArray in
        return tempArray.compactMap { temp in
          let promedio: Double = temp.reduce(.zero, +) / Double(temp.count)
          return String(format: DomainConstants.decimalFormat, promedio)
        }
      }
      .eraseToAnyPublisher()
  }
}

// MARK: - protocol
protocol GetFiveDaysForecastTempUseCaseProtocol {
  func execute() -> AnyPublisher<[String], NetworkError>
}
