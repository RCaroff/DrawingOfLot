//
//  String+Extensions.swift
//  DrawingOfLot
//
//  Created by Rémi Caroff on 06/09/2019.
//  Copyright © 2019 Rémi Caroff. All rights reserved.
//

import Foundation

extension String {
  func isReallyEmpty() -> Bool {
    return self.replacingOccurrences(of: " ", with: "").isEmpty
  }
}
