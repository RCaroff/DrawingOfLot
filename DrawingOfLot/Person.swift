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
  var joint: String {
    switch name {
    case "Rémi":
      return "Camille"
    case "Benjamin":
      return "Sandrine"
    case "Nicolas":
      return "Nathalie"
    case "Philippe":
      return "Marie-France"
    case "Camille":
      return "Rémi"
    case "Sandrine":
      return "Benjamin"
    case "Nathalie":
      return "Nicolas"
    case "Marie-France":
      return "Philippe"
    default:
      return ""
    }
  }
  @Published var receiver: String = ""
  
  init(name: String) {
    self.name = name
  }
}
