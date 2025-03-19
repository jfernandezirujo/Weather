//
//  FiveDaysForecastView.swift
//  WeatherApp
//
//  Created by Julieta Fernandez Irujo on 30/09/2024.
//

import SwiftUI

struct FiveDaysForecastView: View {
  
  // MARK: - Properties
  var daysForecastWeather: [DayForecastModel]
  
  // MARK: - body
    var body: some View {
      HStack(spacing: PresentationConstants.weatherDaysSpacing) {
        ForEach(daysForecastWeather) { dayForecast in
          DayForecastView(dayForecastWeather: dayForecast)
        }
      }
    }
}
