//
//  DateHelper.swift
//  WeatherApp
//
//  Created by Julieta Fernandez Irujo on 01/10/2024.
//

import Foundation

class DateHelper {
  
  // MARK: - Properies
  lazy private var getDateFormatter: DateFormatter = {
    return DateFormatter()
  }()
  
  // MARK: - Methods
  func formatDate(
    date: Date,
    format: String
  ) -> String {
    getDateFormatter.dateFormat = format
    return getDateFormatter.string(from: date)
  }
  
  func getWeekDayString() -> [String] {
    let nextFiveDates: [Date] = getNextFiveDays()
    getDateFormatter.dateFormat = PresentationConstants.weekDayFormat
    getDateFormatter.locale = Locale(identifier: PresentationConstants.formatterIdentifier)
    return nextFiveDates.map { formatDate(date: $0) }
  }
  
  func formatTimeInterval(with timeInterval: TimeInterval) -> Date {
    Date(timeIntervalSince1970: timeInterval)
  }
  
  func isDayTime() -> Bool {
    let currentTimeString: String = formatDate(date: Date())
    let currentTime: Date = getDateFormatter.date(from: currentTimeString) ?? Date()
    let eveningTime: Date = getDateFormatter.date(from: DomainConstants.nightTime) ?? Date()
    
    return currentTime <= eveningTime
  }
  
  func removeToday(from weatherList: [WeatherDTO]) -> [WeatherDTO] {
    return weatherList.filter { !isNotToday(with: $0.dt) }
  }
  
  // MARK: - Private Methods
  private func getNextFiveDays() -> [Date] {
    let calendar: Calendar = Calendar.current
    guard let tomorrow: Date = calendar.date(byAdding: .day, value: DomainConstants.one, to: Date()) else { return [Date()] }
    
    return (.zero..<DomainConstants.five).compactMap {
      calendar.date(
        byAdding: .day,
        value: $0,
        to: tomorrow)
    }
  }
  
  private func formatDate(date: Date) -> String {
    return getDateFormatter.string(from: date)
  }
  
  private func isNotToday(with timeInterval: TimeInterval) -> Bool {
    let entryDate: Date = formatTimeInterval(with: timeInterval)
    return Calendar.current.isDateInTomorrow(entryDate)
  }
}
