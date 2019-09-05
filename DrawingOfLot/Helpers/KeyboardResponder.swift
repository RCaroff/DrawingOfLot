//
//  KeyboardResponder.swift
//  DrawingOfLot
//
//  Created by Rémi Caroff on 22/08/2019.
//  Copyright © 2019 Rémi Caroff. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

struct AdaptsToSoftwareKeyboard: ViewModifier {
  
  @State var currentHeight: CGFloat = 0
  
  func body(content: Content) -> some View {
    content
      .padding(.bottom, currentHeight)
      .edgesIgnoringSafeArea(currentHeight == 0 ? Edge.Set() : .bottom)
      .onAppear(perform: subscribeToKeyboardEvents)
  }
  
  private let keyboardWillOpen = NotificationCenter.default
    .publisher(for: UIResponder.keyboardWillShowNotification)
    .map { $0.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect }
    .map { $0.height }
  
  private let keyboardWillHide =  NotificationCenter.default
    .publisher(for: UIResponder.keyboardWillHideNotification)
    .map { _ in CGFloat.zero }
  
  private func subscribeToKeyboardEvents() {
    _ = Publishers.Merge(keyboardWillOpen, keyboardWillHide)
      .subscribe(on: RunLoop.main)
      .assign(to: \.currentHeight, on: self)
  }
}
