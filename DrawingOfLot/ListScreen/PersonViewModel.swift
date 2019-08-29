//
//  PersonViewModel.swift
//  DrawingOfLot
//
//  Created by Rémi Caroff on 27/08/2019.
//  Copyright © 2019 Rémi Caroff. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

final class PersonViewModel: ObservableObject, Identifiable {
  @Published var name: String = ""
  @Published var joint: String = ""
  @Published var receiver: String = ""

  var displayJoint: Bool {
    return !joint.replacingOccurrences(of: " ", with: "").isEmpty
  }
  
  init(name: String, joint: String = "", receiver: String = "") {
    self.name = name
    self.joint = joint
    self.receiver = receiver
  }
}
