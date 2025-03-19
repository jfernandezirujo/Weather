//
//  View+Extension.swift
//  WeatherApp
//
//  Created by Julieta Fernandez Irujo on 03/10/2024.
//

import SwiftUI

extension View {
  @ViewBuilder
  func ifTrue<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
    if condition {
      transform(self)
    } else {
      self
    }
  }
}
