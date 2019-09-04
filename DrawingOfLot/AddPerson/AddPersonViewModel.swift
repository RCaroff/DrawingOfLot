//
//  AddPersonViewModel.swift
//  DrawingOfLot
//
//  Created by Rémi Caroff on 02/09/2019.
//  Copyright © 2019 Rémi Caroff. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class AddPersonViewModel: ObservableObject {
  
  @Published var nameInputText: String = ""
  @Published var emailInputText: String = ""
  @Published var jointNameInputText: String = ""
  @Published var jointEmailInputText: String = ""

  func validateButtonTapped() {
    
  }
}
