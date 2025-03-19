//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Julieta Fernandez Irujo on 23/09/2024.
//

import SwiftUI

@main
struct WeatherAppApp: App {
  
  // MARK: - Properties
  private let weatherViewModel: CurrenWeatherViewModel
  private let useCasesProvider: WeatherUseCasesProviderProtocol
  
  // MARK: - init
  init() {
    self.useCasesProvider = WeatherUseCasesProvider(
      currentTempUseCase: DependencyContainer.makeGetCurrentTempUseCase(),
      currentWeatherIconUseCase: DependencyContainer.makeGetCurrentWeatherIconUseCase(),
      fiveDaysForecastTempUseCase: DependencyContainer.makeGetFiveDaysForecastTempUseCase(),
      fiveDaysForecastIconUseCase: DependencyContainer.makeGetFiveDaysForecastIconUseCase(),
      currentMaxMinTempUseCase: DependencyContainer.makeGetCurrentMaxAndMinTempUseCase(),
      locationNameUseCase: DependencyContainer.makeGetLocationNameUseCase()
    )
  
    self.weatherViewModel = CurrenWeatherViewModel(
      useCasesProvider: useCasesProvider,
      dateHelper: DateHelper()
    )
  }
  
  // MARK: - body
  var body: some Scene {
    WindowGroup {
      CurrentWeatherView()
        .environmentObject(weatherViewModel)
    }
  }
}
