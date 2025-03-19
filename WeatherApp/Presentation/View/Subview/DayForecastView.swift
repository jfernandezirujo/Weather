//
//  DayForecastView.swift
//  WeatherApp
//
//  Created by Julieta Fernandez Irujo on 23/09/2024.
//

import SwiftUI

struct DayForecastView: View {
  
  // MARK: - Properties
  var dayForecastWeather: DayForecastModel
  
  var body: some View {
    VStack {
      Text(dayForecastWeather.day)
        .foregroundStyle(.white)
        .font(
          .system(
            size: PresentationConstants.weatherDayFontSize)
        )
      Image(systemName: dayForecastWeather.conditionName)
        .renderingMode(.original)
        
        .resizable()
        .aspectRatio(contentMode: .fit)
        .foregroundStyle(.white)
        .frame(
          width: PresentationConstants.weatherDayIconFrame,
          height: PresentationConstants.weatherDayIconFrame)
      Text("\(dayForecastWeather.temp)\(PresentationConstants.degreeSymbol)")
        .foregroundStyle(.white)
        .font(
          .system(
            size: PresentationConstants.weatherDayTempFontSize)
        )
    }
  }
}
