//
//  GetFiveDaysForecastIconUseCase.swift
//  WeatherApp
//
//  Created by Julieta Fernandez Irujo on 30/09/2024.
//

import Combine

struct GetFiveDaysForecastIconUseCase: GetFiveDaysForecastIconUseCaseProtocol {
  
  // MARK: - Properties
  private let repository: GetFiveDaysForecastRepositoryProtocol
  
  // MARK: - init
  init(repository: GetFiveDaysForecastRepositoryProtocol) {
    self.repository = repository
  }
  
  // MARK: - Methods
  func execute() -> AnyPublisher<[Int], NetworkError> {
    return repository.getWeatherIcon()
      .map { tempArray in
        return tempArray.compactMap { temp in
          let mostFrequentIcon: Int? = temp.reduce(into: [:]) { counts, icon in
            counts[icon, default: .zero] += DomainConstants.one
          }.max(by: { $0.value < $1.value })?.key
          return mostFrequentIcon ?? .zero
        }
      }
      .eraseToAnyPublisher()
  }
  
}

// MARK: - protocol
protocol GetFiveDaysForecastIconUseCaseProtocol {
  func execute() -> AnyPublisher<[Int], NetworkError>
}
