//
//  UseCaseProvider.swift
//  WeatherApp
//
//  Created by Julieta Fernandez Irujo on 03/10/2024.
//

class WeatherUseCasesProvider: WeatherUseCasesProviderProtocol {
  
  // MARK: - Properties
  let currentTempUseCase: GetCurrentTempUseCaseProtocol
  let currentWeatherIconUseCase: GetCurrentWeatherIconUseCaseProtocol
  let fiveDaysForecastTempUseCase: GetFiveDaysForecastTempUseCaseProtocol
  let fiveDaysForecastIconUseCase: GetFiveDaysForecastIconUseCaseProtocol
  let currentMaxMinTempUseCase: GetCurrentMaxAndMinTempUseCaseProtocol
  let locationNameUseCase: GetLocationNameUseCaseProtocol
  
  // MARK: - init
  init(
    currentTempUseCase: GetCurrentTempUseCaseProtocol,
    currentWeatherIconUseCase: GetCurrentWeatherIconUseCaseProtocol,
    fiveDaysForecastTempUseCase: GetFiveDaysForecastTempUseCaseProtocol,
    fiveDaysForecastIconUseCase: GetFiveDaysForecastIconUseCaseProtocol,
    currentMaxMinTempUseCase: GetCurrentMaxAndMinTempUseCaseProtocol,
    locationNameUseCase: GetLocationNameUseCaseProtocol
  ) {
    self.currentTempUseCase = currentTempUseCase
    self.currentWeatherIconUseCase = currentWeatherIconUseCase
    self.fiveDaysForecastTempUseCase = fiveDaysForecastTempUseCase
    self.fiveDaysForecastIconUseCase = fiveDaysForecastIconUseCase
    self.currentMaxMinTempUseCase = currentMaxMinTempUseCase
    self.locationNameUseCase = locationNameUseCase
  }

}

// MARK: - Protocol
protocol WeatherUseCasesProviderProtocol {
  var currentTempUseCase: GetCurrentTempUseCaseProtocol { get }
  var currentWeatherIconUseCase: GetCurrentWeatherIconUseCaseProtocol { get }
  var fiveDaysForecastTempUseCase: GetFiveDaysForecastTempUseCaseProtocol { get }
  var fiveDaysForecastIconUseCase: GetFiveDaysForecastIconUseCaseProtocol { get }
  var currentMaxMinTempUseCase: GetCurrentMaxAndMinTempUseCaseProtocol { get }
  var locationNameUseCase: GetLocationNameUseCaseProtocol { get }
}
