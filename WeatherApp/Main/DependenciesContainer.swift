//
//  DependenciesContainer.swift
//  WeatherApp
//
//  Created by Julieta Fernandez Irujo on 18/03/2025.
//

class DependencyContainer {
  
  // MARK: - Properties
  private static let apiService: NetworkingManager = NetworkingManager(locationManager: LocationManager())
  private static let dateHelper: DateHelper = DateHelper()
  
  // MARK: - Methods
  static func makeGetCurrentTempUseCase() -> GetCurrentTempUseCaseProtocol {
    let repository: GetCurrentWeatherRepositoryProtocol = GetCurrentWeatherRepository(apiClient: apiService)
    return GetCurrentTempUseCase(repository: repository)
  }
  
  static func makeGetCurrentWeatherIconUseCase() -> GetCurrentWeatherIconUseCaseProtocol {
    let repository: GetCurrentWeatherRepositoryProtocol = GetCurrentWeatherRepository(apiClient: apiService)
    return GetCurrentWeatherIconUseCase(repository: repository)
  }
  
  static func makeGetFiveDaysForecastTempUseCase() -> GetFiveDaysForecastTempUseCaseProtocol {
    let repository: GetFiveDaysForecastRepositoryProtocol = GetFiveDaysForecastRepository(
      apiClient: apiService,
      dateHelper: dateHelper
    )
    return GetFiveDaysForecastTempUseCase(repository: repository)
  }
  
  static func makeGetFiveDaysForecastIconUseCase() -> GetFiveDaysForecastIconUseCaseProtocol {
    let repository: GetFiveDaysForecastRepositoryProtocol = GetFiveDaysForecastRepository(
      apiClient: apiService,
      dateHelper: dateHelper
    )
    return GetFiveDaysForecastIconUseCase(repository: repository)
  }
  
  static func makeGetCurrentMaxAndMinTempUseCase() -> GetCurrentMaxAndMinTempUseCaseProtocol {
    let repository: GetCurrentWeatherRepositoryProtocol = GetCurrentWeatherRepository(apiClient: apiService)
    return GetCurrentMaxAndMinTempUseCase(repository: repository)
  }
  
  static func makeGetLocationNameUseCase() -> GetLocationNameUseCaseProtocol {
    let repository: GetCurrentWeatherRepositoryProtocol = GetCurrentWeatherRepository(apiClient: apiService)
    return GetLocationNameUseCase(repository: repository)
  }
}
