//
//  ContentView.swift
//  WeatherApp
//
//  Created by Julieta Fernandez Irujo on 23/09/2024.
//

import SwiftUI

struct CurrentWeatherView: View {
  
  // MARK: - Properties
  @EnvironmentObject var viewModel: CurrenWeatherViewModel
  
  // MARK: - body
  var body: some View {
    ZStack {
      gradientBackground
      VStack {
        cityTitle
        currentTemperature
        Spacer()
        weatherDaysView
        Spacer()
      }
    }
    .onAppear {
      viewModel.fetchWeatherData()
    }
  }
  
  // MARK: - Subviews
  private var gradientBackground: some View {
    LinearGradient(
      colors: viewModel.dateHelper.isDayTime() ? [.blue, .cyan] : [.black, .gray],
      startPoint: .topLeading,
      endPoint: .bottomTrailing)
    .edgesIgnoringSafeArea(.all)
  }
  
  private var cityTitle: some View {
    HStack {
      Spacer()
      Text(viewModel.model.location)

      Spacer()
      refreshButton
    }
    .font(
      .system(
        size: PresentationConstants.titleFontSize,
        weight: .medium)
    )
    .foregroundStyle(.white)
    .padding(.bottom, PresentationConstants.titleBottomPadding)
    .padding(.horizontal, PresentationConstants.cityTitlePadding)
  }

  private var currentTemperature: some View {
    VStack(spacing: PresentationConstants.currentTempSpacing) {
      Image(systemName: viewModel.model.conditionName)
        .resizable()
        .ifTrue(viewModel.dateHelper.isDayTime()) {
          $0.renderingMode(.original)
        }
        .ifTrue(!viewModel.dateHelper.isDayTime()) {
          $0.foregroundStyle(.white)
        }
        .aspectRatio(contentMode: .fit)
        .frame(
          width: PresentationConstants.currentTempFrame,
          height: PresentationConstants.currentTempFrame)

      Text("\(viewModel.model.temp)\(PresentationConstants.degreeSymbol)")
        .foregroundStyle(.white)
        .font(
          .system(
            size: PresentationConstants.currentTempFontSize,
            weight: .medium)
        )
      Text(viewModel.model.minAndMaxTemp)
        .foregroundStyle(.white)
        .font(.system(
          size: PresentationConstants.maxAndMinTempFontSize,
          weight: .regular
        ))
    }
  }
  
  private var weatherDaysView: some View {
    FiveDaysForecastView(daysForecastWeather: viewModel.array)
  }
  
  private var refreshButton: some View {
    CustomButton(
      imageName: PresentationConstants.refreshButtonImageName,
      action: {
        viewModel.fetchWeatherData()
      })
  }
}
