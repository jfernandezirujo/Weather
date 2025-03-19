//
//  NetworkError.swift
//  WeatherApp
//
//  Created by Julieta Fernandez Irujo on 24/09/2024.
//

enum NetworkError: Error {
  case networkError(Error)
  case generic
  case invalidURL
  case decodingError(Error)
  case apiKeyMissing
}
