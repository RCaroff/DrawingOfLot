//
//  PersonsRepository.swift
//  DrawingOfLot
//
//  Created by Rémi Caroff on 04/09/2019.
//  Copyright © 2019 Rémi Caroff. All rights reserved.
//

import Foundation
import Combine

final class PersonsRepository: ObservableObject {
  
  static let shared = PersonsRepository()
  
  @Published var persons: [Person] = []
  @Published var editingPerson: Person = Person(name: "")
  
  func add(person: Person) {
    persons.append(person)
  }
  
  func deletePerson(withName name: String) {
    persons.removeAll { $0.name == name }
  }
}
