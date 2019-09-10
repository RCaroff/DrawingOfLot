//
//  InfoPlistHelper.swift
//  DrawingOfLot
//
//  Created by Rémi Caroff on 09/09/2019.
//  Copyright © 2019 Rémi Caroff. All rights reserved.
//

import Foundation

class InfoPlistHelper {
  static func infoForKey(_ key: String) -> String? {
    return (Bundle.main.infoDictionary?[key] as? String)?
      .replacingOccurrences(of: "\\", with: "")
  }
}


