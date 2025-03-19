//
//  CustomButton.swift
//  WeatherApp
//
//  Created by Julieta Fernandez Irujo on 09/10/2024.
//

import SwiftUI

struct CustomButton: View {
  var imageName: String
  var action: () -> Void
  
  var body: some View {
    Button(action: {
      action()
    })
    {
      Image(systemName: imageName)
        .resizable()
        .frame(
          width: PresentationConstants.cutomButtonFrameSice,
          height:  PresentationConstants.cutomButtonFrameSice
        )
    }
  }
}
