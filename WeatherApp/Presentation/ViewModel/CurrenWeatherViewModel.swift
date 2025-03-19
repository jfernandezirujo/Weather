//
//  CurrenWeatherViewModel.swift
//  WeatherApp
//
//  Created by Julieta Fernandez Irujo on 26/09/2024.
//

import Combine
import Foundation
import SwiftUI

class CurrenWeatherViewModel: ObservableObject, CurrenWeatherViewModelProtocol {
  
  // MARK: - Properties
  @Published var model: WeatherModel = WeatherModel()
  @Published var array: [DayForecastModel] = []
  let useCasesProvider: WeatherUseCasesProviderProtocol
  let dateHelper: DateHelper
  var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
  
  // MARK: - init
  init(
    useCasesProvider: WeatherUseCasesProviderProtocol,
    dateHelper: DateHelper
  ) {
    self.useCasesProvider = useCasesProvider
    self.dateHelper = dateHelper
    fetchWeatherData()
  }
  
  // MARK: - Private Methods
  private func setCurrentWeatherData() {
    let temperaturePublisher: AnyPublisher<String, NetworkError> = useCasesProvider.currentTempUseCase.execute()
    let iconPublisher: AnyPublisher<Int, NetworkError> = useCasesProvider.currentWeatherIconUseCase.execute()
    let minAndMAxPublisher: AnyPublisher<String, NetworkError> = useCasesProvider.currentMaxMinTempUseCase.execute()
    let locationPublisher: AnyPublisher<String, NetworkError> = useCasesProvider.locationNameUseCase.execute()
    
    Publishers.CombineLatest4(temperaturePublisher, iconPublisher, minAndMAxPublisher, locationPublisher)
      .sink(receiveCompletion: { _ in },
            receiveValue: { temperatureData, iconData, minAndMAx, locationData in
        self.model = WeatherDataMapper.mapWeatherModel(
          id: iconData,
          temp: temperatureData,
          minAndMax: minAndMAx,
          location: locationData
        )
      }
      )
      .store(in: &cancellables)
  }
  
  private func setFiveDayWeatherData() {
    let temperaturePublisher: AnyPublisher<[String], NetworkError> = useCasesProvider.fiveDaysForecastTempUseCase.execute()
    let iconPublisher: AnyPublisher<[Int], NetworkError> = useCasesProvider.fiveDaysForecastIconUseCase.execute()
    let date: [String] = dateHelper.getWeekDayString()
    Publishers.Zip(temperaturePublisher, iconPublisher)
      .sink(receiveCompletion: { _ in },
            receiveValue: { temperatureData, iconData in
        self.array =  WeatherDataMapper.mapFiveDaysForecastModel(
          temperatureData: temperatureData,
          iconData: iconData,
          date: date)
      })
      .store(in: &cancellables)
  }

  // MARK: - Methods
  func fetchWeatherData() {
    setCurrentWeatherData()
    setFiveDayWeatherData()
  }
}

// MARK: - protocol
protocol CurrenWeatherViewModelProtocol {
  func fetchWeatherData()
}
