//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Julieta Fernandez Irujo on 05/10/2024.

import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject, LocationManagerProtocol {
  
  // MARK: - Properties
  private let locationManager = CLLocationManager()
  private let locationSubject = PassthroughSubject<CLLocation?, Never>()
  private var authorizationStatus = PassthroughSubject<CLAuthorizationStatus, Never>()
  
  var locationPublisher: AnyPublisher<CLLocation?, Never> {
    locationSubject.eraseToAnyPublisher()
  }
  
  // MARK: - init
  override init() {
    super.init()
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    requestPermissions()
    checkAuthorizationStatus()
  }
  
  // MARK: - Methods
  func getCurrentLocation() -> AnyPublisher<LocationEntity, Never> {
    return authorizationStatus
      .filter { $0 == .authorizedWhenInUse || $0 == .authorizedAlways }
      .flatMap { _ in self.requestLocation() }
      .compactMap { $0 }
      .map { location in
        LocationEntity(
          latitude: location.coordinate.latitude,
          longitude: location.coordinate.longitude
        )
      }
      .eraseToAnyPublisher()
  }
  
  private func requestLocation() -> AnyPublisher<CLLocation?, Never> {
    locationManager.requestLocation()
    return locationPublisher
  }
  
  private func checkAuthorizationStatus() {
    let status = locationManager.authorizationStatus
    authorizationStatus.send(status)
  }
  func requestPermissions() {
    locationManager.requestWhenInUseAuthorization()
  }
}

// MARK: - CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    authorizationStatus.send(status)
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let lastLocation = locations.last else { return }
    
    DispatchQueue.main.async {
      self.locationSubject.send(lastLocation)
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError: Error) {
    print(666)
  }
}

// MARK: - Protocol
protocol LocationManagerProtocol {
  func getCurrentLocation() -> AnyPublisher<LocationEntity, Never>
}
