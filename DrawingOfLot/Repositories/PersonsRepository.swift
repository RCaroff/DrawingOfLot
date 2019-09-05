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
  
  // Public
  @Published var persons: [Person] = []
  @Published var editingName: String = ""
  
  var personsCount: Int {
    personsTmp.count
  }
  
  // Private
  private var personsTmp: [Person] = []
  
  init() {
    print("PersonsRepository init")
  }
  
  func add(person: Person) {
    personsTmp.append(person)
    persons = personsTmp
  }
  
  func update(person: Person, keypath: ReferenceWritableKeyPath<Person, String>, value: String) {
    guard let indexToUpdate = personsTmp.firstIndex(where: { $0.name == person.name }) else { return }
    personsTmp[indexToUpdate][keyPath: keypath] = value
  }

  func update(at index: Int, keypath: ReferenceWritableKeyPath<Person, String>, value: String) {
    personsTmp[index][keyPath: keypath] = value
  }
  
  func deletePerson(withName name: String) {
    personsTmp.removeAll { $0.name == name }
    persons = personsTmp
  }
  
  func deletePerson(at indexSet: IndexSet) {
    personsTmp.remove(atOffsets: indexSet)
    persons = personsTmp
  }
  
  func getPerson(at index: Int) -> Person {
    personsTmp[index]
  }
  
  func getJoint(for person: Person) -> Person? {
    personsTmp.first { $0.name == person.joint }
  }
  
  func getJoint(forPersonName name: String) -> Person? {
    personsTmp.first { $0.joint == name }
  }
}
