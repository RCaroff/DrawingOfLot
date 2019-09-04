//
//  Person.swift
//  DrawingOfLot
//
//  Created by Rémi Caroff on 22/08/2019.
//  Copyright © 2019 Rémi Caroff. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class Person: ObservableObject {
  @Published var name: String = ""
  @Published var joint: String = ""
  @Published var receiver: String = ""
  
  var isSingle: Bool {
    joint.replacingOccurrences(of: " ", with: "").isEmpty
  }
  
  init(name: String) {
    self.name = name
  }
}
